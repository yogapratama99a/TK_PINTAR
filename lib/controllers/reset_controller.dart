import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';

class NewPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxBool isLoading = false.obs;

  late String email;

  @override
  void onInit() {
    // Ambil email dari argument navigasi
    email = Get.arguments ?? '';
    super.onInit();
  }

  void togglePasswordVisibility() {
    passwordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.toggle();
  }

  Future<bool> setNewPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validasi input
    if (password.isEmpty) {
      passwordError.value = 'Kata sandi wajib diisi';
      return false;
    } else if (password.length < 6) {
      passwordError.value = 'Minimal 6 karakter';
      return false;
    } else {
      passwordError.value = '';
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi sandi wajib diisi';
      return false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = 'Konfirmasi tidak cocok';
      return false;
    } else {
      confirmPasswordError.value = '';
    }

    isLoading.value = true;

    try {
      final response = await ApiService.post(
        'forgot-password/new-password',
        {
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response['success'] == true) {
        Get.offAllNamed('/forgot-password/password-updated');
        return true;
      } else {
        _handleErrorResponse(response);
        return false;
      }
    } catch (e) {
      CustomSnackbar.error('Gagal mengatur ulang kata sandi. Coba lagi.');
      print('NewPassword Error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _handleErrorResponse(Map<String, dynamic> response) {
    final statusCode = response['statusCode'] ?? 400;
    final message = response['message'] ?? 'Terjadi kesalahan';

    switch (statusCode) {
      case 422:
        passwordError.value = response['errors']?['password']?.first ?? '';
        confirmPasswordError.value =
            response['errors']?['password_confirmation']?.first ?? '';
        break;
      case 500:
      case 503:
        CustomSnackbar.error(
            'Sistem sedang gangguan. Silakan coba lagi nanti.');
        break;
      case 404:
        CustomSnackbar.error('Email tidak terdaftar di sistem kami.');
        break;
      default:
        CustomSnackbar.error(message);
    }

    print('NewPassword Error Response: $response');
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
