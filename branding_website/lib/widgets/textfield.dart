import 'package:flutter/material.dart';

import '../styles/appstyles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final TextStyle? hintStyle;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.borderColor = AppStyles.backgroundColor,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled = true,
    this.hintStyle
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.subtitleStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}
