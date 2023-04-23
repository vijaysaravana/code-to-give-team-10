import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genie/utils/colors.dart';

import '../widgets/post_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/logo.svg",
          color: whiteColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.messenger_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 0, 22, 34.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: mobileBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Discover',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: blueColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'WHAT’S NEW TODAY',
                      ),
                      Text(
                        'BROWSE ALL',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // POSTS
                Column(
                  children: [
                    PostCard(),
                    PostCard(),
                    PostCard(),
                    PostCard(),
                    PostCard(),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'SEE MORE',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
