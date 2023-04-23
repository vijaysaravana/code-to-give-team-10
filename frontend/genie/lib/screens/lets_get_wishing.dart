import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/screens/chat.dart';
import 'package:genie/utils/colors.dart';

class GetWishing extends StatefulWidget {
  const GetWishing({super.key});

  @override
  State<GetWishing> createState() => _GetWishingState();
}

class _GetWishingState extends State<GetWishing> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Chat()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blueColor, lightBlueColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 1,
            ),
            Text(
              "Make a wish!",
              style: TextStyle(
                  fontSize: 30, color: whiteColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Let's get to Wishing!",
              style: TextStyle(
                  fontSize: 15, color: whiteColor, fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/signup.jpeg"),
              radius: 50,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Connecting you!",
              style: TextStyle(
                  fontSize: 30, color: whiteColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              color: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
