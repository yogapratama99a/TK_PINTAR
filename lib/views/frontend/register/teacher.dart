import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:tk_pertiwi/views/widgets/dropdown.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';

class RegisterTeacherScreen extends StatefulWidget {
  const RegisterTeacherScreen({super.key});

  @override
  _RegisterTeacherScreenState createState() => _RegisterTeacherScreenState();
}

class _RegisterTeacherScreenState extends State<RegisterTeacherScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedPosition = "TK A1";

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
                    Image.asset('assets/img/logo.png', width: 120, height: 120),
                    SizedBox(height: 16),
                    Text(
                      "TK PINTAR",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Input Email
              CustomInputField(
                label: "Email",
                hintText: "Masukkan Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),

              // Input NIP
              CustomInputField(
                label: "NIP",
                hintText: "Masukkan NIP",
                controller: nipController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),

              // Dropdown Jabatan Guru
              CustomDropdown(
                label: "Jabatan Guru",
                items: ["TK A1", "TK A2", "TK B1", "TK B2"],
                initialValue: selectedPosition,
                onChanged: (value) {
                  setState(() {
                    selectedPosition = value;
                  });
                },
              ),
              const SizedBox(height: 8),

              // Input Password
              CustomInputField(
                label: "Kata Sandi",
                hintText: "Masukkan Kata Sandi",
                controller: passwordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 8),

              // Konfirmasi Password
              CustomInputField(
                label: "Konfirmasi Kata Sandi",
                hintText: "Konfirmasi Kata Sandi",
                controller: confirmPasswordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),

              Center(
                child: AuthButton(
                  text: 'DAFTAR',
                  onPressed: () {
                    // Tambahkan aksi saat tombol daftar ditekan
                  },
                ),
              ),
              const SizedBox(height: 10),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Apakah anda sudah memiliki akun?",
                      style: TextStyle(
                          fontSize: 12, fontFamily: AppFonts.PoppinsRegular),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/login'); // Gunakan GetX routing
                      },
                      child: const Text(
                        " Masuk",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
