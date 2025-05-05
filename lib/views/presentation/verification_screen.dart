import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/code_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/otp_input_box.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';

class VerificationScreen extends StatelessWidget {
  final controller = Get.put(CodeController());

  VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Verifikasi Kode OTP",
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
          // Tambahkan Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Masukkan kode untuk melakukan verifikasi akun!",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.PoppinsRegular,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Obx(() => Column(
                    children: [
                      OtpBoxInput(
                        controller: controller.otpController,
                        errorText: controller.otpError.value,
                        onChanged: (val) {
                          if (val.length == 6) controller.verifyOtp();
                        },
                      ),
                    ],
                  )),

              // Tombol Kirim Ulang Kode
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => controller.resendOtp(),
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

              Center(
                child: Obx(() => RegisterButton(
                      text: 'Kirim',
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.verifyOtp,
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
