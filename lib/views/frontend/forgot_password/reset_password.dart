import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'password_updated.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "KATA SANDI BARU",
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
              "Masukkan kata sandi baru dan konfirmasi kata sandi!",
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.PoppinsRegular,
                color: Colors.black,
                fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Input Kata Sandi Baru
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukkan kata sandi baru",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input Konfirmasi Kata Sandi
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Konfirmasi kata sandi baru",
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

            // Tombol Kirim yang Menyesuaikan Lebar
            SizedBox(
              width: double.infinity,
              child: AuthButton(
                text: "Kirim",
                icon: Icons.send,
                onPressed: () {
                  if (_passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Harap isi semua kolom!")),
                    );
                    return;
                  }

                  if (_passwordController.text != _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kata sandi tidak cocok!")),
                    );
                    return;
                  }

                  Get.toNamed('/updated');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
