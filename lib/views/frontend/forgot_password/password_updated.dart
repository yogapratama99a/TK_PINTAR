import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: AppColors.green, size: 80),
              const SizedBox(height: 16),
              const Text(
                "Kata Sandi Berhasil Diperbarui",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: AppFonts.PoppinsBold,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Silakan masuk kembali dengan kata sandi baru.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.PoppinsRegular,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AuthButton(
                      text: 'MASUK',
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      backgroundColor: AppColors.green,
                      foregroundColor: AppColors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
