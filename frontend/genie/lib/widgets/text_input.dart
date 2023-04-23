import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPwd;
  final String hintText;
  final TextInputType textInputType;

  const TextInput({
    super.key,
    this.isPwd = false,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder, 
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8)
      ),
      keyboardType: textInputType,
      obscureText: isPwd,
    );
  }
}