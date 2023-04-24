import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genie/screens/chat.dart';

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Chats",
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Chat()),
                  );
                },
                child: ChatListItem(
                  userName: "Wish Coordinator",
                  lastChat: "Thank you!",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chat(
                        userName: 'Will Kenny',
                        chatHistory: [
                          [
                            't',
                            'Hey Will! I found your profile from my discover page and I was truly inspired!'
                          ],
                          [
                            'f',
                            'Glad I inspired you! Do you also volunteer at Make a wish, Georgia?'
                          ],
                          [
                            't',
                            'No, but i would love to! Could you show me how to apply as a volunteer?'
                          ],
                          [
                            'f',
                            'Of course! You Just have to click on the \'Star\' icon and apply.'
                          ],
                          ['t', 'Okay, thank you!']
                        ],
                      ),
                    ),
                  );
                },
                child: ChatListItem(
                  userName: "Will Kenny",
                  lastChat: "Thank you!",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chat(
                        userName: 'Beth Charles',
                        chatHistory: [
                          [
                            't',
                            'Hey Will! I found your profile from my discover page and I was truly inspired!'
                          ],
                          [
                            'f',
                            'Glad I inspired you! Do you also volunteer at Make a wish, Georgia?'
                          ],
                          [
                            't',
                            'No, but i would love to! Could you show me how to apply as a volunteer?'
                          ],
                          [
                            'f',
                            'Of course! You Just have to click on the \'Star\' icon and apply.'
                          ],
                          ['t', 'Okay, thank you!']
                        ],
                      ),
                    ),
                  );
                },
                child: ChatListItem(
                  userName: "Beth Charles",
                  lastChat: "Thank you!",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chat(
                        userName: 'Roronoa Zoro',
                        chatHistory: [
                          [
                            't',
                            'Hey Will! I found your profile from my discover page and I was truly inspired!'
                          ],
                          [
                            'f',
                            'Glad I inspired you! Do you also volunteer at Make a wish, Georgia?'
                          ],
                          [
                            't',
                            'No, but i would love to! Could you show me how to apply as a volunteer?'
                          ],
                          [
                            'f',
                            'Of course! You Just have to click on the \'Star\' icon and apply.'
                          ],
                          ['t', 'Okay, thank you!']
                        ],
                      ),
                    ),
                  );
                },
                child: ChatListItem(
                  userName: "Roronoa Zoro",
                  lastChat: "Thank you!",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chat(
                        userName: 'Rev Shawn',
                        chatHistory: [
                          [
                            't',
                            'Hey Will! I found your profile from my discover page and I was truly inspired!'
                          ],
                          [
                            'f',
                            'Glad I inspired you! Do you also volunteer at Make a wish, Georgia?'
                          ],
                          [
                            't',
                            'No, but i would love to! Could you show me how to apply as a volunteer?'
                          ],
                          [
                            'f',
                            'Of course! You Just have to click on the \'Star\' icon and apply.'
                          ],
                          ['t', 'Okay, thank you!']
                        ],
                      ),
                    ),
                  );
                },
                child: ChatListItem(
                  userName: "Rev Shawn",
                  lastChat: "Thank you!",
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
