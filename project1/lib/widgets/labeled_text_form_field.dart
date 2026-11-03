import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// TextFormField dengan label tepat di atas kotak (sesuai Style Guide).
///
/// Di dalamnya tetap memakai TextFormField + validator (BAB 6).
class LabeledTextFormField extends StatelessWidget {
  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
