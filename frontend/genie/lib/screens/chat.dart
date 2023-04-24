import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/widgets/chat_bubble.dart';

import '../utils/colors.dart';

class Chat extends StatefulWidget {
  final String userName;
  final chatHistory;

  const Chat({
    super.key,
    this.userName = "Wish Coordinator",
    this.chatHistory = const [
      ['f', 'Hi! I am Ashley! How can I help you today?']
    ],
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.userName,
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            for (var msg in widget.chatHistory)
              if (msg[0] == 'f')
                FromChatBubble(
                  msg: msg[1],
                )
              else
                ToChatBubble(
                  msg: msg[1],
                )
          ],
        ),
      ),
    );
  }
}
