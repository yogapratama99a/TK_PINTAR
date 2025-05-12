import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  var userId = ''.obs;
  var userRole = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  var studentBorn = ''.obs;
  var studentGender = ''.obs;
  var studentReligion = ''.obs;

  var parentName = ''.obs;
  var parentAddress = ''.obs;
  var parentPhone = ''.obs;

  // Tambahan untuk teacher
  var teacherName = ''.obs;
  var teacherNip = ''.obs;
  var teacherBorn = ''.obs;
  var teacherAddress = ''.obs;
  var teacherPhone = ''.obs;
  var teacherAboutMe = ''.obs;

  var isPasswordVisible = false.obs;
  var errorMessages = <String, String>{'email': '', 'password': ''}.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validasi input
    if (email.isEmpty || password.isEmpty) {
      errorMessages['email'] = email.isEmpty ? 'Email wajib diisi' : '';
      errorMessages['password'] =
          password.isEmpty ? 'Password wajib diisi' : '';
      isLoading.value = false;
      return;
    }

    // Kirim request login ke API
    final response = await ApiService.post('login', {
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      try {
        final data = response['data'];
        final role = data['role'];
        var token = data['token'];
        final profile = data['profile'];

        if (role == null || token == null || profile == null) {
          errorMessage.value = 'Data login tidak lengkap dari server';
          CustomSnackbar.error(errorMessage.value);
          isLoading.value = false;
          return;
        }

        // Cek apakah token sudah kadaluarsa
        if (isTokenExpired(token)) {
          // Token expired, coba refresh token
          final refreshResponse = await ApiService.refreshToken();
          if (refreshResponse['success']) {
            final newToken = refreshResponse['data']['token'];
            if (newToken != null) {
              // Simpan token baru ke SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', newToken);

              // Coba login ulang dengan token baru
              return login(context);
            } else {
              errorMessage.value = 'Gagal mendapatkan token baru';
              CustomSnackbar.error(errorMessage.value);
            }
          } else {
            errorMessage.value = 'Gagal memperbarui token';
            CustomSnackbar.error(errorMessage.value);
          }
        } else {
          // Simpan ke SharedPreferences jika token valid
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', role);
          await prefs.setString('profile', jsonEncode(profile));

          box.write('user_id', profile['user_id']);
          box.write('user_role', role);
          box.write('name', profile['name']);
          box.write('email', profile['email']);

          // Simpan FCM token setelah user_id ada
          await ApiService.saveFcmToken(profile['user_id'].toString());

          // Set data student (anak)
          final student = profile['student'];
          if (student != null) {
            studentName.value = student['name'] ?? '';
            studentImageUrl.value = student['image'] ?? '';
            studentBorn.value = student['ttl'] ?? '';
            studentGender.value = student['gender'] ?? '';
            studentReligion.value = student['religion'] ?? '';
            parentName.value = profile['name'] ?? '';
            parentAddress.value = profile['address'] ?? '';
            parentPhone.value = profile['phone_number'] ?? '';
          }

          // Set data teacher (guru)
          final teacher = profile['teacher'];
          if (teacher != null) {
            teacherName.value = teacher['name'] ?? '';
            teacherNip.value = teacher['nip'] ?? '';
            teacherBorn.value = teacher['ttl'] ?? '';
            teacherAddress.value = teacher['address'] ?? '';
            teacherPhone.value = teacher['phone_number'] ?? '';
            teacherAboutMe.value = teacher['about_me'] ?? '';
          }

          // Bersihkan input dan error
          emailController.clear();
          passwordController.clear();
          errorMessages['email'] = '';
          errorMessages['password'] = '';
          errorMessage.value = '';

          CustomSnackbar.success('Login berhasil!');
          await Future.delayed(const Duration(seconds: 2));

          // Navigasi berdasarkan role
          if (role == 'teacher') {
            Get.offAllNamed('/home-teacher');
          } else if (role == 'parent') {
            Get.offAllNamed('/home-parent');
          } else {
            errorMessage.value = 'Role pengguna tidak valid';
            CustomSnackbar.error(errorMessage.value);
          }
        }
      } catch (e) {
        errorMessage.value = 'Gagal parsing data pengguna';
        CustomSnackbar.error(errorMessage.value);
      }
    } else {
      errorMessage.value = response['message'] ?? 'Login gagal. Coba lagi.';
      CustomSnackbar.error(errorMessage.value);
    }

    isLoading.value = false;
  }

// Fungsi untuk memeriksa apakah token sudah kadaluarsa
  bool isTokenExpired(String token) {
    try {
      final jwt = JWT.decode(token); // Decode JWT token
      final expiry =
          jwt.payload['exp']; // Ambil waktu kadaluarsa (exp) dari payload
      if (expiry == null) {
        return true; // Jika tidak ada waktu kadaluarsa, anggap expired
      }
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(
          expiry * 1000); // Ubah epoch ke DateTime
      return expirationDate
          .isBefore(DateTime.now()); // Cek apakah token sudah kadaluarsa
    } catch (e) {
      return true; // Jika ada error decoding, anggap token expired
    }
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');
    if (profileString != null) {
      final profile = jsonDecode(profileString);

      // Ambil data student
      final student = profile['student'];
      if (student != null) {
        studentImageUrl.value = student['image'] ?? '';
        studentName.value = student['name'] ?? '';
        studentBorn.value = student['ttl'] ?? '';
        studentGender.value = student['gender'] ?? '';
        studentReligion.value = student['religion'] ?? '';
        parentName.value = profile['name'] ?? '';
        parentAddress.value = profile['address'] ?? '';
        parentPhone.value = profile['phone_number'] ?? '';
      }

      // Ambil data teacher
      final teacher = profile['teacher'];
      if (teacher != null) {
        teacherName.value = teacher['name'] ?? '';
        teacherNip.value = teacher['nip'] ?? '';
        teacherBorn.value = teacher['ttl'] ?? '';
        teacherAddress.value = teacher['address'] ?? '';
        teacherPhone.value = teacher['phone_number'] ?? '';
        teacherAboutMe.value = teacher['about_me'] ?? '';
      }
    }
  }
}
