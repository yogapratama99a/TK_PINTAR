import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/services/api_service.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';

class RegisterTeacherController extends GetxController {
  // TextEditingControllers
  final nameController = TextEditingController();
  final nipController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Validation flags
  final isValid = RxMap<String, bool>({
    'name': false,
    'nip': false,
    'email': false,
    'password': false,
    'confirmPassword': false,
  });

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final registerSuccess = false.obs;

  // Error messages
  final errorMessages = RxMap<String, String>({
    'name': '',
    'nip': '',
    'email': '',
    'password': '',
    'confirmPassword': '',
  });

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupValidationListeners();
  }

  // Setup listeners for real-time validation
  void _setupValidationListeners() {
    nameController.addListener(() => _validateField('name'));
    nipController.addListener(() => _validateField('nip'));
    emailController.addListener(() => _validateField('email'));
    passwordController.addListener(() => _validateField('password'));
    confirmPasswordController.addListener(() => _validateField('confirmPassword'));
  }

  // Generic field validation
  void _validateField(String field) {
    switch (field) {
      case 'name':
        _validateName();
        break;
      case 'nip':
        _validateNip();
        break;
      case 'email':
        _validateEmail();
        break;
      case 'password':
        _validatePassword();
        break;
      case 'confirmPassword':
        _validateConfirmPassword();
        break;
    }
  }

  void _validateName() {
    final name = nameController.text;
    if (name.isEmpty) {
      errorMessages['name'] = 'Nama tidak boleh kosong';
      isValid['name'] = false;
    } else if (!RegExp(r'^[a-zA-Z .,]+$').hasMatch(name)) {
      errorMessages['name'] = 'Nama hanya boleh mengandung huruf, titik, dan koma';
      isValid['name'] = false;
    } else {
      errorMessages['name'] = '';
      isValid['name'] = true;
    }
  }

  void _validateNip() {
    final nip = nipController.text;
    if (nip.isEmpty) {
      errorMessages['nip'] = 'NIP tidak boleh kosong';
      isValid['nip'] = false;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(nip)) {
      errorMessages['nip'] = 'NIP hanya boleh mengandung angka';
      isValid['nip'] = false;
    } else if (nip.length < 8) {
      errorMessages['nip'] = 'NIP minimal 8 digit';
      isValid['nip'] = false;
    } else {
      errorMessages['nip'] = '';
      isValid['nip'] = true;
    }
  }

  void _validateEmail() {
    final email = emailController.text;
    if (email.isEmpty) {
      errorMessages['email'] = 'Email tidak boleh kosong';
      isValid['email'] = false;
    } else if (!GetUtils.isEmail(email)) {
      errorMessages['email'] = 'Email tidak valid';
      isValid['email'] = false;
    } else {
      errorMessages['email'] = '';
      isValid['email'] = true;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.toggle();
  }

  void _validatePassword() {
    final password = passwordController.text;
    if (password.isEmpty) {
      errorMessages['password'] = 'Kata sandi tidak boleh kosong';
      isValid['password'] = false;
    } else if (password.length < 6) {
      errorMessages['password'] = 'Kata sandi minimal 6 karakter';
      isValid['password'] = false;
    } else {
      errorMessages['password'] = '';
      isValid['password'] = true;
    }
    // Re-validate confirm password when password changes
    _validateConfirmPassword();
  }

  void _validateConfirmPassword() {
    final confirm = confirmPasswordController.text;
    final password = passwordController.text;
    if (confirm.isEmpty) {
      errorMessages['confirmPassword'] = 'Konfirmasi kata sandi tidak boleh kosong';
      isValid['confirmPassword'] = false;
    } else if (confirm != password) {
      errorMessages['confirmPassword'] = 'Kata sandi tidak cocok';
      isValid['confirmPassword'] = false;
    } else {
      errorMessages['confirmPassword'] = '';
      isValid['confirmPassword'] = true;
    }
  }

  void showSuccess() {
    registerSuccess.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      // Kosongkan semua field input
      nameController.clear();
      emailController.clear();
      nipController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Reset validasi dan error
      isValid.assignAll({
        'name': false,
        'nip': false,
        'email': false,
        'password': false,
        'confirmPassword': false,
      });

      errorMessages.assignAll({
        'name': '',
        'nip': '',
        'email': '',
        'password': '',
        'confirmPassword': '',
      });

      // Reset visibilitas password
      isPasswordVisible.value = false;
      isConfirmPasswordVisible.value = false;
    });
  }

  void hideSuccess() {
    registerSuccess.value = false;
  }

  bool get isFormValid => isValid.values.every((valid) => valid);

  Future<void> registerTeacher() async {
    // Validate all fields
    _validateName();
    _validateEmail();
    _validateNip();
    _validatePassword();
    _validateConfirmPassword();

    if (!isFormValid) {
      CustomSnackbar.error("Harap perbaiki data yang tidak valid");
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiService.post(
        'register-teacher',
        {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
          'nip': nipController.text,
        },
      );

      if (response['statusCode'] == 201) {
        showSuccess();
      } else {
        CustomSnackbar.error("Pendaftaran gagal: ${response['message'] ?? 'Unknown error'}");
      }

      if (response['errors'] != null) {
        final errors = response['errors'] as Map<String, dynamic>;

        errors.forEach((key, value) {
          if (key == 'email') {
            errorMessages['email'] = value[0];
            isValid['email'] = false;
            emailController.clear();
          }
          if (key == 'nip') {
            errorMessages['nip'] = value[0];
            isValid['nip'] = false;
            nipController.clear();
          }
          if (key == 'password') {
            errorMessages['password'] = value[0];
            isValid['password'] = false;
            passwordController.clear();
            confirmPasswordController.clear();
          }
        });

        final allErrors = errors.values.map((e) => e[0]).join('\n');
        CustomSnackbar.error(allErrors);
      }
        } catch (e) {
      CustomSnackbar.error("Terjadi kesalahan: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    nipController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
