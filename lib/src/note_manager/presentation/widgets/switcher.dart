

import 'package:banter/core/res/color.dart';
import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  const Switcher({
    super.key,
    required this.height,
    required this.width,
    required this.icon,
  });

  final double height;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.07,
      width: width * 0.15,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: ContinuousRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            width * 0.07,
          ),
        ),
        child: Icon(
          icon,
          color: BanterColors.textColor1,
        ),
      ),
    );
  }
}
