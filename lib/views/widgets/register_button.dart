import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final bool isLoading;
  final double iconSize;
  final EdgeInsetsGeometry? padding;

  const RegisterButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width = 300,
    this.height = 50, // Increased for better touch area
    this.isLoading = false,
    this.iconSize = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.blue,
          foregroundColor: foregroundColor ?? AppColors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.grey[400],
        ),
        icon: _buildIcon(),
        label: _buildLabel(),
      ),
    );
  }

  Widget _buildIcon() {
    if (isLoading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: const CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: 2.5,
        ),
      );
    }
    return icon != null
        ? Icon(
            icon,
            size: iconSize,
            color: foregroundColor ?? AppColors.white,
          )
        : const SizedBox(width: 0);
  }

  Widget _buildLabel() {
    return isLoading
        ? const SizedBox()
        : Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.PoppinsBold,
              fontWeight: FontWeight.w600,
              color: foregroundColor ?? AppColors.white,
              letterSpacing: 0.5,
            ),
          );
  }
}