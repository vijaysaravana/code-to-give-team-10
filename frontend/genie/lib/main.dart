import 'package:flutter/material.dart';
import 'package:genie/responsive/mobile_layout.dart';
import 'package:genie/responsive/reponsive_layout_screen.dart';
import 'package:genie/responsive/web_layout.dart';
import 'package:genie/screens/add_post_screen.dart';
import 'package:genie/screens/login_screen.dart';
import 'package:genie/screens/signup_screen.dart';
import 'package:genie/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Make-a-wish Genie',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const ResponsiveLayout(
        webScreenLayout: WebLayout(),
        mobileScreenLayout: MobileLayout(),
        // mobileScreenLayout: AddPost(),
        // mobileScreenLayout: LoginScreen(),
        // mobileScreenLayout: SignupScreen(),
      ),
    );
  }
}
