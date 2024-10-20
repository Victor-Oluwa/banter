

import 'package:flutter/material.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/res/fonts.dart';

class BanterTextWidget extends StatelessWidget {
  const BanterTextWidget({
    super.key,
    required this.text,
    this.size = 20,
    this.overflow,
    this.font = BanterFonts.balooBhai,
    this.color = BanterColors.textColor1,
  });

  final String text;
  final double size;
  final String font;
  final Color color;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: font,
        fontSize: size,
        color: color,
      ),
    );
  }
}
