import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static bottomSnackbar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        backgroundColor: Colors.black54,
        colorText: Colors.white);
  }
}
