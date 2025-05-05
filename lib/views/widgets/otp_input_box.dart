import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class OtpBoxInput extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final String errorText;
  final Function(String)? onChanged;

  const OtpBoxInput({
    super.key,
    required this.controller,
    this.length = 6,
    this.errorText = '',
    this.onChanged,
  });

  @override
  State<OtpBoxInput> createState() => _OtpBoxInputState();
}

class _OtpBoxInputState extends State<OtpBoxInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.length, (index) {
                final text = widget.controller.text;
                final digit = index < text.length ? text[index] : '';

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.blue,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        digit,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.PoppinsBold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // Hidden TextField to capture input
        Opacity(
          opacity: 0.0,
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            maxLength: widget.length,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(counterText: ''),
          ),
        ),
        if (widget.errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.errorText,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.red,
                  fontFamily: AppFonts.PoppinsRegular,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
