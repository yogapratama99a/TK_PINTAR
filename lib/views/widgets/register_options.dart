import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';

class RegisterOptions {
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: const Center(
              child: Text(
                "Daftar Sebagai",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: AppFonts.PoppinsBold,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthButton(
                  text: "Guru",
                  onPressed: () {
                    Get.toNamed('/teacher');
                  },
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                ),
                const SizedBox(height: 12),
                AuthButton(
                  text: "Wali Murid",
                  onPressed: () {
                    Get.toNamed('/parent');
                  },
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
