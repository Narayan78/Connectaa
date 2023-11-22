import 'dart:io';
import 'package:connectaa/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/enums/message_enums.dart';
import '../../../common/utiles/utiles.dart';
import '../controller/chat_controller.dart';

class ButtomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ButtomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<ButtomChatField> createState() => _ButtomChatFieldState();
}

class _ButtomChatFieldState extends ConsumerState<ButtomChatField> {
  bool isToSend = false;

  final TextEditingController _messageController = TextEditingController();

  void sendTextMessage() async {
    if (isToSend) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
          );
    }

    _messageController.clear();
  }

  void sendFileMessage(File file, MessageEnum messageType) {
    ref.read(chatControllerProvider).sendFileMessage(
          context: context,
          file: file,
          recieverUserId: widget.recieverUserId,
          messageType: messageType,
        );
  }

  void selectImageToSend() async {
    File? Imagefile = await imagePickerFromGallery(context);
    if (Imagefile != null) {
      sendFileMessage(Imagefile, MessageEnum.image);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4),
              child: TextFormField(
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isToSend = true;
                    });
                  } else {
                    setState(() {
                      isToSend = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions),
                    color: Colors.grey,
                  ),
                  suffixIcon: SizedBox(
                    width: 96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectImageToSend,
                          icon: Icon(Icons.camera_alt),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.attach_file),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  hintText: "Type a message ...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              onTap: sendTextMessage,
              child: CircleAvatar(
                backgroundColor: Color(0xFF128C7E),
                child: Icon(
                  isToSend ? Icons.send : Icons.mic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
