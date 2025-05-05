import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class CustomSnackbar {
  static void success(String message) {
    Get.snackbar(
      'Sukses',
      message,
      icon: const Icon(Icons.check_circle, color: AppColors.greenn),
      backgroundColor: AppColors.lightBlue,
      colorText: AppColors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  static void error(String message) {
    Get.snackbar(
      'Gagal',
      message,
      icon: const Icon(Icons.error, color: AppColors.red),
      backgroundColor: AppColors.lightBlue,
      colorText: AppColors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  static void warning(String message) {
    Get.snackbar(
      'Peringatan',
      message,
      icon: const Icon(Icons.warning, color: AppColors.yellow),
      backgroundColor: AppColors.lightBlue,
      colorText: AppColors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }
}
