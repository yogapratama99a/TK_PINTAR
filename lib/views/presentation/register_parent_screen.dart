import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/register_parent_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';
import 'package:tk_pertiwi/views/widgets/register_success.dart';

class RegisterParentScreen extends StatelessWidget {
  RegisterParentScreen({super.key});

  final controller = Get.put(RegisterParentController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 24.0),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/img/logo.png',
                              width: 120, height: 120),
                          const SizedBox(height: 16),
                          const Text(
                            "TK PINTAR",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Bergabunglah sebagai wali murid di TK Pintar\nIsi formulir berikut untuk mendaftar",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                              fontFamily: AppFonts.PoppinsRegular,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => BorderLabelInputField(
                        borderLabel: "Nama Siswa",
                        hintText: "Masukkan Nama Lengkap",
                        controller: controller.nameController,
                        errorText: controller.errorMessages['name'] ?? '',
                        isError: controller.errorMessages['name']!.isNotEmpty,
                      )),
                  const SizedBox(height: 8),
                  Obx(() => BorderLabelInputField(
                        borderLabel: "Email",
                        hintText: "Masukkan Email",
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: controller.errorMessages['email'] ?? '',
                        isError: controller.errorMessages['email']!.isNotEmpty,
                      )),
                  const SizedBox(height: 8),
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
                  Obx(() {
                    final isConfirmPasswordVisible =
                        controller.isConfirmPasswordVisible.value;
                    return BorderLabelInputField(
                      borderLabel: "Konfirmasi Kata Sandi",
                      hintText: "Konfirmasi Kata Sandi",
                      controller: controller.confirmPasswordController,
                      isPassword: !isConfirmPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      errorText: controller.errorMessages['confirmPassword'] ?? '',
                      isError: controller.errorMessages['confirmPassword']!.isNotEmpty,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.grey600,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Center(
                    child: Obx(() => RegisterButton(
                          text: 'Daftar',
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.registerParent,
                          isLoading: controller.isLoading.value,
                          icon: Icons.person_add_alt_1,
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Apakah anda sudah memiliki akun?",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.PoppinsRegular,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: const Text(
                            " Masuk",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.PoppinsRegular,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue,
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
        ),
        // Jika ada overlay khusus:
        RegisterSuccessOverlay(
          isVisible: controller.registerSuccess,
          onClose: controller.hideSuccess,
          onGoToLogin: () => Get.offAllNamed('/login'),
        ),
      ],
    );
  }
}
