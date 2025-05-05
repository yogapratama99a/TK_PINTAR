// views/widgets/custom_input_field.dart

import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final int? maxLines;
  final bool expands;
  final bool readOnly; // Tambahan baru
  final void Function()? onTap; // Tambahan baru
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.expands = false,
    this.readOnly = false, // Default false
    this.onTap, // Tambahan baru
    this.validator,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: widget.maxLines! > 1 ? 60 : 48,
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword && !_isPasswordVisible,
            maxLines: widget.expands ? null : widget.maxLines,
            expands: widget.expands,
            readOnly: widget.readOnly, // Tambahan
            onTap: widget.onTap, // Tambahan
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.green),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.green),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
              alignLabelWithHint: true,
            ),
          ),
        ),
      ],
    );
  }
}
