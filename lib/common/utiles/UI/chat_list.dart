import 'package:connectaa/colors.dart';
import 'package:connectaa/common/utiles/UI/info.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            if (messages[index]["isMe"] == true) {
              return MyChatListCard(
                message: messages[index]["text"].toString(),
                date: messages[index]["time"].toString(),
              );
            } else {
              return SenderChatListCard(
                message: messages[index]["text"].toString(),
                date: messages[index]["time"].toString(),
              );
            }
          }),
    );
  }
}

class MyChatListCard extends StatelessWidget {
  final String message;
  final String date;
  const MyChatListCard({super.key, required this.date, required this.message});

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
                padding: const EdgeInsets.only(
                    bottom: 20, left: 10, right: 30, top: 5),
                child: Text(message, style: const TextStyle(fontSize: 16)),
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
  const SenderChatListCard(
      {super.key, required this.date, required this.message});

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
                child: Text(message, style: const TextStyle(fontSize: 16)),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style:
                          const TextStyle(fontSize: 13, color: Color.fromARGB(92, 255, 255, 255)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 18,
                      color: Color.fromARGB(92, 255, 255, 255)
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
