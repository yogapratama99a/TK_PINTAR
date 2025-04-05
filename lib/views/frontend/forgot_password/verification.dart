import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/reset_password.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  void _resendCode() {
    // Simulasi pengiriman ulang kode
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Kode verifikasi telah dikirim ulang!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "VERIFIKASI KODE",
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
            const SizedBox(height: 16),
            const Text(
              "Masukkan kode untuk melakukan verifikasi akun!",
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.PoppinsRegular,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Input Kode Verifikasi
            SizedBox(
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Masukkan kode",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tombol Kirim Ulang Kode
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _resendCode,
                child: const Text(
                  "Kirim ulang kode",
                  style: TextStyle(
                    color: AppColors.green,
                    fontFamily: AppFonts.PoppinsSemiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tombol Kirim yang Menyesuaikan Lebar
            SizedBox(
              width: double.infinity,
              child: AuthButton(
                text: "Kirim",
                icon: Icons.send,
                onPressed: () {
                   Get.toNamed('/reset');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
