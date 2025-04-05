import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/send_email.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:tk_pertiwi/views/widgets/register_options.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';
import 'package:tk_pertiwi/views/backend/home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 5.0,
                      ),
                    ),
                    const SizedBox(height: 42),
                    Image.asset(
                      'assets/img/logo.png',
                      width: 128,
                      height: 128,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: const Text(
                  "TK PINTAR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              CustomInputField(
                label: "Email",
                hintText: "Masukkan Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomInputField(
                label: "Kata Sandi",
                hintText: "Masukkan Kata Sandi",
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/email');
                  },
                  child: const Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFonts.PoppinsMedium,
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tombol MASUK di tengah
              Center(
                child: AuthButton(
                  text: 'MASUK',
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                ),
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Apakah anda belum memiliki akun?",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFonts.PoppinsRegular,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RegisterOptions.show(context);
                    },
                    child: const Text(
                      " Daftar",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppFonts.PoppinsRegular,
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
