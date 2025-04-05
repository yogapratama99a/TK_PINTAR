import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Ubah Kata Sandi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: AppFonts.PoppinsSemiBold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              
              // Current Password
              CustomInputField(
                label: "Kata Sandi Lama",
                controller: _oldPasswordController,
                hintText: 'Masukkan kata sandi lama',
                isPassword: true,
              ),
              
              const SizedBox(height: 16),
              
              // New Password
              CustomInputField(
                label: "Kata Sandi Baru",
                controller: _newPasswordController,
                hintText: 'Masukkan kata sandi baru',
                isPassword: true,
              ),
              
              const SizedBox(height: 8),
              
              // Password Requirements
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kata sandi harus mengandung:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.green[400]),
                        const SizedBox(width: 4),
                        Text(
                          'Minimal 8 karakter',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.green[400]),
                        const SizedBox(width: 4),
                        Text(
                          'Huruf besar dan kecil',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Confirm Password
              CustomInputField(
                label: "Konfirmasi Kata Sandi Baru",
                controller: _confirmPasswordController,
                hintText: 'Masukkan ulang kata sandi baru',
                isPassword: true,
              ),
              
              const SizedBox(height: 24),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proses ganti password
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SIMPAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}