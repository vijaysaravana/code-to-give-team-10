import 'dart:convert';
import 'package:genie/screens/profile.dart';
import 'package:genie/screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genie/utils/colors.dart';
import 'package:genie/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
  }

  bool isLoggedIn = false;
  bool success = true;
  String userInfo = '';

  Future<void> login() async {
    var map = new Map<String, dynamic>();

    map['email'] = _emailController.text.trim();
    map['password'] = _pwdController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/userlogin'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(map),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          userInfo = response.body;
          isLoggedIn = true;
        });
      } else {
        setState(() {
          success = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn && userInfo != ''
        ? Profile(userInfo: json.decode(userInfo))
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    // logo (svg image)
                    Image.asset(
                      'assets/logo.png',
                      height: 64,
                    ),

                    const SizedBox(
                      height: 64,
                    ),
                    // input for email
                    TextInput(
                      hintText: "Enter your email",
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // input for pwd
                    TextInput(
                      hintText: "Password",
                      textInputType: TextInputType.text,
                      isPwd: true,
                      textEditingController: _pwdController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // log in button
                    InkWell(
                      onTap: () async {
                        await login();
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          color: blueColor,
                        ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    !success
                        ? Text(
                            "Log in Failed!",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: redColor),
                          )
                        : Text(''),

                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text("Don't have an account?"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                    // Transision to sign up
                  ],
                ),
              ),
            ),
          );
  }
}
