import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/login_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';
import 'package:tk_pertiwi/views/widgets/register_options.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Selamat Datang",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 5.0,
                  )),
              const SizedBox(height: 42),
              Hero(
                tag: 'logo-hero',
                child:
                    Image.asset('assets/img/logo.png', width: 128, height: 128),
              ),
              const SizedBox(height: 16),
              const Text("TK PINTAR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  )),
              const SizedBox(height: 32),

              // EMAIL FIELD
              Obx(() => BorderLabelInputField(
                    borderLabel: "Email",
                    hintText: "Masukkan Email",
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    errorText: controller.errorMessages['email'] ?? '',
                    isError: controller.errorMessages['email']!.isNotEmpty,
                  )),
              const SizedBox(height: 12),

              // PASSWORD FIELD
              Obx(() {
                final isPasswordVisible = controller.isPasswordVisible.value;
                return BorderLabelInputField(
                  borderLabel: "Kata Sandi",
                  hintText: "Masukkan Kata Sandi",
                  controller: controller.passwordController,
                  isPassword: !isPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  errorText: controller.errorMessages['password'] ?? '',
                  isError: controller.errorMessages['password']!.isNotEmpty,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey600,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                );
              }),
              const SizedBox(height: 8),

              // ERROR MESSAGE
              Obx(() => Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  )),

              const SizedBox(height: 8,),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/forgot-password/check-email'),
                  child: const Text("Lupa Kata Sandi?",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppFonts.PoppinsMedium,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              const SizedBox(height: 16),

              // LOGIN BUTTON
              Obx(() => RegisterButton(
                    text: 'Masuk',
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.login(context),
                    isLoading: controller.isLoading.value,
                    icon: Icons.login,
                    backgroundColor: AppColors.blue,
                    foregroundColor: AppColors.white,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                  )),
              const SizedBox(height: 8),

              // REGISTER OPTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Apakah anda belum memiliki akun?",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppFonts.PoppinsRegular,
                      )),
                  GestureDetector(
                    onTap: () => RegisterOptions.show(context),
                    child: const Text(" Daftar",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.PoppinsRegular,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue,
                        )),
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
