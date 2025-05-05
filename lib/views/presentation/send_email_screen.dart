import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/email_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';

class SendEmailScreen extends StatelessWidget {
  final controller = Get.put(EmailController());

  SendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Verifikasi Email",
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.PoppinsBold,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                "Masukkan Email Anda Untuk Mencari Akun!",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.PoppinsRegular,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),

              Obx(() => BorderLabelInputField(
                        borderLabel: "Email",
                        hintText: "Masukkan Email",
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: controller.emailError.value,
                        isError: controller.emailError.value.isNotEmpty,
                      )),

              const SizedBox(height: 24),
              Center(
                    child: Obx(() => RegisterButton(
                          text: 'Kirim',
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.sendVerificationEmail,
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
