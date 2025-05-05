import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class BorderLabelInputField extends StatelessWidget {
  const BorderLabelInputField({
    super.key,
    required this.borderLabel,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.errorText,
    this.isError = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  final String borderLabel;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? errorText;
  final bool isError;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged; // ✅ Tambahkan parameter onChanged

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: keyboardType,
                onChanged: onChanged, // ✅ Pasang onChanged ke TextField

                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.InterRegular,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.InterRegular,
                    color: AppColors.grey600,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isError ? AppColors.red : AppColors.blue,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isError ? AppColors.red : AppColors.blue,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isError ? AppColors.red : AppColors.blue,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.white,
                child: Text(
                  borderLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.PoppinsRegular,
                    color: isError ? AppColors.red : AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (errorText?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.red,
                fontFamily: AppFonts.PoppinsRegular,
              ),
            ),
          ),
      ],
    );
  }
}
