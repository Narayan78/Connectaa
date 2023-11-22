import 'package:connectaa/colors.dart';
import 'package:connectaa/common/enums/message_enums.dart';
import 'package:connectaa/features/chat/controller/chat_controller.dart';
import 'package:connectaa/features/chat/widgets/message_card.dart';
import 'package:connectaa/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({super.key, required this.recieverUserId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<MessageModel>>(
        stream:
            ref.watch(chatControllerProvider).chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageScrollController
                .jumpTo(messageScrollController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: messageScrollController,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              var messageData = snapshot.data![index];
              var timeFormat = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyChatListCard(
                  messageType: messageData.type,
                  message: messageData.text,
                  date: timeFormat,
                );
              } else {
                return SenderChatListCard(
                  messageType: messageData.type,
                  message: messageData.text,
                  date: timeFormat,
                );
              }
            },
          );
        },
      ),
    );
  }
}

class MyChatListCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum messageType;
  const MyChatListCard(
      {super.key,
      required this.date,
      required this.message,
      required this.messageType});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(
            children: [
              Padding(
                padding: messageType == MessageEnum.text
                    ? const EdgeInsets.only(
                        bottom: 20,
                        left: 10,
                        right: 30,
                        top: 5,
                      )
                    : const EdgeInsets.only(
                        bottom: 25,
                        top: 5,
                      ),
                child: MessageCardChild(
                  message: message,
                  messageType: messageType,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 18,
                      color: Colors.white60,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SenderChatListCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum messageType;
  const SenderChatListCard(
      {super.key,
      required this.date,
      required this.message,
      required this.messageType});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: senderMessageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, left: 10, right: 30, top: 5),
                  child: MessageCardChild(
                    message: message,
                    messageType: messageType,
                  )),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(92, 255, 255, 255)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.done_all,
                        size: 18, color: Color.fromARGB(92, 255, 255, 255))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
