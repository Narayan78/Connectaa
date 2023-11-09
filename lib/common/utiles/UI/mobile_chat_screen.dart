

import 'package:connectaa/colors.dart';
import 'package:connectaa/common/utiles/UI/chat_list.dart';
import 'package:connectaa/common/utiles/UI/info.dart';

import 'package:flutter/material.dart';

class MobileChatScreen extends StatelessWidget {
  const MobileChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(info[0]["name"].toString()),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.video_call)),
           IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ChatList())
        ],
      )
    );
  }
}