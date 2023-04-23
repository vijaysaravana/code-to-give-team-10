import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../widgets/chat_list.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

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
          onPressed: () {},
        ),
        title: Text(
          "Chats",
          style: TextStyle(color: primaryColor),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.messenger_outline,
        //       color: yellowColor,
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              ChatListItem(
                userName: "Wish Coordinator",
                lastChat: "Thank you!",
              ),
              ChatListItem(
                userName: "Will Kenny",
                lastChat: "Thank you!",
              ),
              ChatListItem(
                userName: "Beth Charles",
                lastChat: "Thank you!",
              ),
              ChatListItem(
                userName: "Roronoa Zoro",
                lastChat: "Thank you!",
              ),
              ChatListItem(
                userName: "Rev Shawn",
                lastChat: "Thank you!",
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
