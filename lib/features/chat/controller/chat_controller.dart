import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:connectaa/features/chat/repository/chat_repository.dart';
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

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    print("Controller field is called");
    ref.read(userDataProvider).whenData(
          (value) => {
            print("data is arrived"),
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


