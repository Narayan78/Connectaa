import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectaa/common/enums/message_enums.dart';
import 'package:flutter/material.dart';

class MessageCardChild extends StatelessWidget {
  final String message;
  final MessageEnum messageType;
  const MessageCardChild(
      {super.key, required this.message, required this.messageType});

  @override
  Widget build(BuildContext context) {
    return messageType == MessageEnum.text
        ? Text(message, style: const TextStyle(fontSize: 16))
        : CachedNetworkImage(
            imageUrl: message,
            width: 200,
            height: 200,
          );
  }
}
