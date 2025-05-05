import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';

class CodeController extends GetxController {
  final otpController = TextEditingController();
  final RxString otpError = ''.obs;
  final RxBool isLoading = false.obs;

  late String email;

  @override
  void onInit() {
    // Ambil email dari argument saat navigasi
    email = Get.arguments ?? '';
    super.onInit();
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    // Validasi input
    if (otp.length != 6 || !GetUtils.isNumericOnly(otp)) {
      otpError.value = 'Kode OTP harus 6 digit angka';
      return;
    }

    otpError.value = '';
    isLoading.value = true;

    try {
      final response = await ApiService.post(
        'forgot-password/verify-otp',
        {
          'email': email,
          'otp': otp,
        },
      );

      if (response['success'] == true) {
        CustomSnackbar.success('Verifikasi berhasil. Silakan lanjutkan.');
        otpController.clear();
        // Navigasi ke halaman reset password (atau sesuai kebutuhanmu)
        Get.toNamed('/forgot-password/new-password', arguments: email);
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      CustomSnackbar.error('Gagal memverifikasi kode. Coba lagi.');
      print('Verify OTP Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    isLoading.value = true;

    try {
      final response = await ApiService.post(
        'forgot-password/check-email',
        {'email': email},
      );

      if (response['success'] == true) {
        final maskedEmail = response['data']['email'] ?? email;
        CustomSnackbar.success('Kode baru telah dikirim ke $maskedEmail');
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      CustomSnackbar.error(
          'Gagal mengirim ulang kode. Coba beberapa saat lagi.');
      print('Resend OTP Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleErrorResponse(Map<String, dynamic> response) {
    final statusCode = response['statusCode'] ?? 400;
    final message = response['message'] ?? 'Terjadi kesalahan';

    switch (statusCode) {
      case 422:
        final errors = response['errors']?['otp']?.first;
        otpError.value = errors ?? 'Kode tidak valid';
        break;
      case 409:
        if (message.contains('sudah pernah digunakan')) {
          CustomSnackbar.error(
              'Kode OTP sudah pernah digunakan. Silakan kirim ulang.');
        } else {
          final maskedEmail = response['data']?['email'] ?? email;
          CustomSnackbar.warning(
            'Kode verifikasi masih aktif. Silakan cek kembali email $maskedEmail.',
          );
        }
        break;
      case 410:
        CustomSnackbar.error('Kode OTP sudah kedaluwarsa. Kirim ulang kode.');
        break;
      case 404:
        CustomSnackbar.error('Email tidak terdaftar di sistem kami.');
        break;
      case 409:
        final maskedEmail = response['data']?['email'] ?? email;
        CustomSnackbar.warning(
          'Kode verifikasi masih aktif. Silakan cek kembali email $maskedEmail.',
        );
        break;
      case 500:
      case 503:
        CustomSnackbar.error(
            'Sistem sedang gangguan. Silakan coba lagi nanti.');
        break;
      default:
        CustomSnackbar.error(message);
    }

    print('OTP Error Response: $response');
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
