import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';

class EmailController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxString emailError = ''.obs;
  RxBool isLoading = false.obs;

 Future<void> sendVerificationEmail() async {
  final email = emailController.text.trim();

  if (email.isEmpty || !GetUtils.isEmail(email)) {
    emailError.value = 'Email tidak valid';
    return;
  }

  emailError.value = '';
  isLoading.value = true;

  try {
    final response = await ApiService.post(
      'forgot-password/check-email',
      {'email': email},
    );

    // Log responsenya untuk debugging
    print('API Response: $response');

    if (response['success'] == true) {
      final maskedEmail = response['data']['email'] ?? email;
      CustomSnackbar.success(
        'Kode verifikasi telah dikirim ke $maskedEmail. Silakan cek email Anda.',
      );
      Get.toNamed('/forgot-password/verify-otp', arguments: email);
      emailController.clear();
    } else {
      _handleErrorResponse(response); // Hanya sekali log & handle
    }
  } catch (e) {
    print('Unexpected error: $e');
    CustomSnackbar.error('Terjadi kesalahan. Silakan coba lagi.');
  } finally {
    isLoading.value = false;
  }
}

void _handleErrorResponse(Map<String, dynamic> response) {
  final statusCode = response['statusCode'] ?? 400;
  final message = response['message'] ?? 'Terjadi kesalahan';

  switch (statusCode) {
    case 404:
      CustomSnackbar.error('Email tidak terdaftar di sistem kami');
      break;
    case 409:
      final maskedEmail = response['data']?['email'] ?? emailController.text.trim();
      CustomSnackbar.warning(
        'Kode verifikasi masih aktif. Silakan cek kembali email $maskedEmail.',
      );
      Future.delayed(const Duration(seconds: 1), () {
        Get.toNamed('/forgot-password/verify-otp', arguments: emailController.text.trim());
      });
      break;
    case 422:
      final errors = response['errors']?['email']?.first;
      emailError.value = errors ?? 'Format email tidak valid';
      break;
    case 500:
    case 503:
      CustomSnackbar.error('Sistem email sedang gangguan. Silakan coba lagi nanti.');
      break;
    default:
      CustomSnackbar.error(message);
  }

  // Hapus log duplikat, cukup 1x log untuk debugging
  print('Handled Error Response: $response');
}

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
