import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectaa/common/enums/message_enums.dart';

class MessageModel {
  final String senderId;
  final String recieverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final MessageEnum type;
  final bool isSeen;

  MessageModel({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.type,
    required this.isSeen,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      text: map['text'],
      timeSent: (map['timeSent'] as Timestamp).toDate(),
      messageId: map['messageId'],
      type: map['type'].toString().toEnum(),
      isSeen: map['isSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'timeSent': timeSent,
      'messageId': messageId,
      'type': type.type,
      'isSeen': isSeen,
    };
  }
}
