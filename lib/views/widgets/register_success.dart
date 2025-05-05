import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/register_button.dart';

class RegisterSuccessOverlay extends StatelessWidget {
  final RxBool isVisible;
  final VoidCallback onClose;
  final VoidCallback onGoToLogin;

  const RegisterSuccessOverlay({
    super.key,
    required this.isVisible,
    required this.onClose,
    required this.onGoToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!isVisible.value) return const SizedBox.shrink();

      return Stack(
        children: [
          // Background overlay yang menutupi seluruh layar
          ModalBarrier(
            color: Colors.black.withOpacity(0.5),
            dismissible: true,
            onDismiss: onClose,
          ),

          // Dialog content
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: AppColors.blue, size: 80),
                    const SizedBox(height: 16),
                    const Text(
                      "Pendaftaran Berhasil!",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppFonts.PoppinsBold,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Akun Anda telah berhasil dibuat,\nSilakan masuk untuk melanjutkan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontFamily: AppFonts.PoppinsRegular,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: onClose,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: AppColors.blue),
                            ),
                            child: const Text(
                              "TUTUP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RegisterButton(
                            text: "MASUK",
                            icon: Icons.login,
                            onPressed: onGoToLogin,
                            backgroundColor: AppColors.blue,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}