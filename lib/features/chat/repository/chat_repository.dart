import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectaa/common/enums/message_enums.dart';
import 'package:connectaa/common/utiles/utiles.dart';
import 'package:connectaa/models/chat_contact.dart';
import 'package:connectaa/models/message_model.dart';
import 'package:connectaa/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContactModel(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(senderUserData.uid)
        .set(recieverChatContact.toMap());

    var senderChatContact = ChatContactModel(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubCollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String recieverUserName,
    required MessageEnum messagetype,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      recieverId: recieverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      type: messagetype,
      isSeen: false,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String reciverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var sendTime = DateTime.now();
      UserModel reciverUserData;
      var userDataMap =
          await firestore.collection('users').doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactsSubcollection(
        senderUser,
        reciverUserData,
        text,
        sendTime,
        reciverUserId,
      );

      var messageId = Uuid().v1();

      _saveMessageToMessageSubCollection(
        recieverUserId: reciverUserId,
        text: text,
        timeSent: sendTime,
        messageId: messageId,
        userName: senderUser.name,
        recieverUserName: reciverUserData.name,
        messagetype: MessageEnum.text,
      );

      print("Message Sent");
    } catch (e) {
      showSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
