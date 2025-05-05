import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Diubah menjadi nullable
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final bool isLoading; // Tambahkan parameter loading state

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width = 300,
    this.height = 40,
    this.isLoading = false, // Default false
  });
@override
Widget build(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: isLoading ? null : onPressed, // Non-aktif saat loading
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.green,
      foregroundColor: foregroundColor ?? AppColors.white,
      minimumSize: Size(width, height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ), // ← tutup style di sini!
    icon: isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : icon != null
            ? Icon(icon, color: Colors.white)
            : const SizedBox.shrink(),
    label: isLoading
        ? const SizedBox() // Kosongkan text saat loading
        : Text(
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