import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:connectaa/features/chat/repository/chat_repository.dart';
import 'package:connectaa/models/chat_contact_model.dart';
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

  Stream<List<ChatContactModel>> ChatContact () {
    print("This Controller funcion is called function is called");
    return chatRepository.getChatContacts();
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
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
}


