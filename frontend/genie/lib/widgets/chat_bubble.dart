import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/utils/colors.dart';

class FromChatBubble extends StatelessWidget {
  final String msg;
  const FromChatBubble(
      {super.key, this.msg = 'Hi! I am Ashley! How can I help you today?'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/signup.jpeg'),
            radius: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: 80,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: lightBlueColor,
            ),
            // width: double.infinity,
            child: Text(msg),
          )
        ],
      ),
    );
  }
}

class ToChatBubble extends StatelessWidget {
  final String msg;
  const ToChatBubble(
      {super.key, this.msg = 'Hi! I am Ashley! How can I help you today?'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 80,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[300],
            ),
            // width: double.infinity,
            child: Text(msg),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/signup.jpeg'),
            radius: 25,
          ),
        ],
      ),
    );
  }
}
