import 'package:flutter/material.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';

class ChangePasswordController {
  static Future<void> changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    // Memeriksa apakah kata sandi baru dan konfirmasi kata sandi cocok
    if (newPassword != confirmPassword) {
      CustomSnackbar.warning('Konfirmasi kata sandi tidak cocok');
      return;
    }

    try {
      // Memanggil API untuk mengubah kata sandi
      final response = await ApiService.put(
        'change-password',
        {
          'current_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword, 
        },
      );

      // Menangani respons dari API
      bool success = response['success'] ?? false;  // Pastikan 'success' ada dan bernilai bool
      if (success) {
        CustomSnackbar.success('Kata sandi berhasil diubah');
        Navigator.pop(context); // Menutup layar ChangePasswordScreen
      } else {
        // Menangani kasus gagal, jika ada error atau kesalahan
        String errorMessage = response['message'] ?? 'Terjadi kesalahan. Silakan coba lagi.';
        CustomSnackbar.error(errorMessage); // Menampilkan pesan error
      }
    } catch (e) {
      CustomSnackbar.error('Terjadi kesalahan. Silakan coba lagi.');
    }
  }
}
