import 'package:banter/core/res/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BanterDialog {
  static SnackbarController show({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: BanterColors.darkTunnel,
      colorText: Colors.white,
    );
  }
}
