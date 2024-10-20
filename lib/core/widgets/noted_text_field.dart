import 'package:banter/core/res/color.dart';
import 'package:flutter/material.dart';
import 'package:banter/core/res/fonts.dart';

class NotedTextField extends StatelessWidget {
  const NotedTextField({
    required this.hintText,
    required this.controller,
    this.contentPadding,
    this.hintColor = Colors.grey,
    this.textColor = BanterColors.textColor1,
    this.borderRadius = 15,
    this.isBorderless = false,
    this.textSize = 18,
    this.hintSize = 18,
    this.isReadOnly = false,
    this.validator,
    super.key,
  });

  final String hintText;
  final Color hintColor;
  final Color textColor;
  final double borderRadius;
  final bool isBorderless;
  final double hintSize;
  final double textSize;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;
  final bool isReadOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      cursorColor: Colors.grey,
      style: TextStyle(
        fontFamily: BanterFonts.balooBhai,
        fontSize: textSize,
        color: textColor,
      ),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: BanterFonts.balooBhai,
          color: hintColor,
          fontSize: hintSize,
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: !isBorderless
              ? const BorderSide(color: Colors.grey)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: !isBorderless
              ? const BorderSide(color: Colors.grey)
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: !isBorderless
              ? const BorderSide(color: Colors.grey)
              : BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
