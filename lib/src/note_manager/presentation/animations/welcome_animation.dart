import 'package:flutter/material.dart';

class WelcomeAnimation {
  final AnimationController controller;
  late Animation<Offset> slideFromLeft;
  late Animation<Offset> slideFromRight;
  late Animation<Offset> slideFromTop;
  late Animation<Offset> slideFromBottom;
  late Animation<double> fadeIn;
  late Animation<double> rotate;
  late Animation<double> pop;

  WelcomeAnimation(this.controller) {
    // Slide from left animation
    slideFromLeft = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Slide from right animation
    slideFromRight = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Slide from top animation
    slideFromTop = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Slide from bottom animation
    slideFromBottom = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Fade in animation
    fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn));

    // Rotate animation (rotates 360 degrees)
    rotate = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Pop (Scale) animation (scales from 0 to full size)
    pop = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }
}
