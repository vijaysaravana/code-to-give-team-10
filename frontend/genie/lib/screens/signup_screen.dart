import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genie/utils/colors.dart';
import 'package:genie/widgets/text_input.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _signUp() async {
    print("im alive");
    var map = new Map<String, dynamic>();

    map['first_name'] = _firstNameController.text.trim();
    map['last_name'] = _lastNameController.text.trim();
    map['email'] = _emailController.text.trim();
    map['role'] = "maker";
    // map['city'] = _cityController.text.trim();
    map['city'] = "Atlanta";
    map['password'] = _pwdController.text.trim();
    map['age'] = _ageController.text.trim();
    map['bio'] = _bioController.text.trim();
    map['phone'] = _phoneController.text.trim();

    print(json.encode(map));

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/usersignup'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(map),
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),

                // Profile pic
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage("assets/signup.jpeg"),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 24,
                ),

                // input for name
                TextInput(
                  hintText: "First Name",
                  textInputType: TextInputType.text,
                  textEditingController: _firstNameController,
                ),

                const SizedBox(
                  height: 24,
                ),

                // input for last name
                TextInput(
                  hintText: "Last name",
                  textInputType: TextInputType.text,
                  textEditingController: _lastNameController,
                ),

                const SizedBox(
                  height: 24,
                ),

                // input for age
                TextInput(
                  hintText: "Age",
                  textInputType: TextInputType.number,
                  textEditingController: _ageController,
                ),

                const SizedBox(
                  height: 24,
                ),

                // input for bio
                TextInput(
                  hintText: "Tell about yourself",
                  textInputType: TextInputType.multiline,
                  textEditingController: _bioController,
                ),

                const SizedBox(
                  height: 24,
                ),

                // input for city
                TextInput(
                  hintText: "city",
                  textInputType: TextInputType.multiline,
                  textEditingController: _cityController,
                ),

                const SizedBox(
                  height: 24,
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

                // input for phone
                TextInput(
                  hintText: "Phone Number",
                  textInputType: TextInputType.phone,
                  textEditingController: _phoneController,
                ),

                const SizedBox(
                  height: 24,
                ),
                // log in button
                InkWell(
                  onTap: () async {
                    await _signUp();
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
                      "Sign up",
                      style: TextStyle(
                          color: whiteColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text("Already have an account?"),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
