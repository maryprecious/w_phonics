import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    required this.textColor,
  });
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      style: TextStyle(color: textColor),

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        
      ),
      cursorColor: Colors.white,
    );
  }
}
