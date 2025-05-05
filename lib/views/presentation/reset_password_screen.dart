import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/reset_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  final controller = Get.put(NewPasswordController());

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Kata Sandi Baru",
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Obx(() {
                final isPasswordVisible = controller.passwordVisible.value;
                return BorderLabelInputField(
                  borderLabel: "Kata Sandi",
                  hintText: "Masukkan Kata Sandi",
                  controller: controller.passwordController,
                  isPassword: !isPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  errorText: controller.passwordError.value,
                  isError: controller.passwordError.value.isNotEmpty,
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
              const SizedBox(height: 16),
              Obx(() {
                final isConfirmPasswordVisible =
                    controller.confirmPasswordVisible.value;
                return BorderLabelInputField(
                  borderLabel: "Konfirmasi Kata Sandi",
                  hintText: "Konfirmasi Kata Sandi",
                  controller: controller.confirmPasswordController,
                  isPassword: !isConfirmPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  errorText: controller.confirmPasswordError.value,
                  isError: controller.confirmPasswordError.value.isNotEmpty,
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
                      text: 'Kirim',
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              final success = await controller.setNewPassword();
                              if (success) {
                              }
                            },
                      isLoading: controller.isLoading.value,
                      icon: Icons.send,
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      width: double.infinity,
                      height: 50,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
