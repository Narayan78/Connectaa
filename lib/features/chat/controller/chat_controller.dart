import 'dart:io';

import 'package:connectaa/common/enums/message_enums.dart';
import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:connectaa/features/chat/repository/chat_repository.dart';
import 'package:connectaa/models/chat_contact_model.dart';
import 'package:connectaa/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContactModel>> ChatContact() {
    print("This Controller funcion is called function is called");
    return chatRepository.getChatContacts();
  }

  Stream<List<MessageModel>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) { 
    print("Chat Controller sendTextMessage function is called");
    ref.read(userDataProvider).whenData(
          (value) => {
            chatRepository.sendTextMessage(
              context: context,
              text: text,
              reciverUserId: recieverUserId,
              senderUser: value!,
            ),
          },
        );
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required MessageEnum messageType,
  }) {
    ref.read(userDataProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value!,
            ref: ref,
            messageType: messageType,
          ),
        );
  }
}
