import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; 
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width; // Tambahkan parameter lebar
  final double height; // Tambahkan parameter tinggi

  const AuthButton({super.key, 
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width = 300,  // Default 277
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.green,
        foregroundColor: foregroundColor ?? AppColors.white,
        minimumSize: Size(width, height), // Menggunakan ukuran yang bisa diubah
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: icon != null 
          ? Icon(icon, color: Colors.white) // Langsung set warna putih di sini
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: AppFonts.PoppinsBold,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
