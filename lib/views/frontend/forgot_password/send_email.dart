import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/verification.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';

class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "VERIFIKASI MELALUI EMAIL",
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.PoppinsBold,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Masukkan email aktif Anda!",
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.PoppinsRegular,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            
            // Kolom Input Email
            SizedBox(
              width: double.infinity, // Mengisi seluruh lebar layar yang tersedia
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Masukan email",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tombol Kirim dengan Lebar Menyesuaikan Inputan Email
            SizedBox(
              width: double.infinity, // Mengisi seluruh lebar layar yang tersedia
              child: AuthButton(
                text: "Kirim",
                icon: Icons.send,
                onPressed: () {
                  Get.toNamed('/verification');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
