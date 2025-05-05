import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';
import 'package:get_storage/get_storage.dart';

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
      errorMessages['password'] = password.isEmpty ? 'Password wajib diisi' : '';
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
        final token = data['token'];
        final profile = data['profile'];

        if (role == null || token == null || profile == null) {
          errorMessage.value = 'Data login tidak lengkap dari server';
          CustomSnackbar.error(errorMessage.value);
          isLoading.value = false;
          return;
        }

        // Simpan ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('profile', jsonEncode(profile));

        box.write('user_id', profile['user_id']);
        box.write('user_role', role);
        box.write('name', profile['name']);
        box.write('email', profile['email']);

        // Set data student (anak)
        final student = profile['student'];
        if (student != null) {
          studentName.value = student['name'] ?? '';
          studentImageUrl.value = student['image'] ?? '';
          studentBorn.value = student['ttl'] ?? '';
          studentGender.value = student['gender'] ?? '';
          studentReligion.value = student['religion'] ?? '';
        }

        // Set data parent (orang tua)
        parentName.value = profile['name'] ?? '';
        parentAddress.value = profile['address'] ?? '';
        parentPhone.value = profile['phone_number'] ?? '';

        // Set data teacher (guru)
        final teacher = profile['teacher'];
        if (teacher != null) {
          teacherName.value = teacher['name'] ?? '';
          teacherNip.value = teacher['nip'] ?? '';
          teacherBorn.value = teacher['ttl'] ?? '';
          teacherAddress.value = teacher['address'] ?? '';
          teacherPhone.value = teacher['phone_number'] ?? '';
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
      }

      // Ambil data parent
      parentName.value = profile['name'] ?? '';
      parentAddress.value = profile['address'] ?? '';
      parentPhone.value = profile['phone_number'] ?? '';

      // Ambil data teacher
      final teacher = profile['teacher'];
      if (teacher != null) {
        teacherName.value = teacher['name'] ?? '';
        teacherNip.value = teacher['nip'] ?? '';
        teacherBorn.value = teacher['ttl'] ?? '';
        teacherAddress.value = teacher['address'] ?? '';
        teacherPhone.value = teacher['phone_number'] ?? '';
      }
    }
  }
}
