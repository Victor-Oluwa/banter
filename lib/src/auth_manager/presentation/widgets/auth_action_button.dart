import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.color,
    required this.text,
  });

  final double width;
  final double height;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: color,
      ),
      child: BanterTextWidget(
        text: text,
        color: BanterColors.textColor1,
      ),
    );
  }
}
