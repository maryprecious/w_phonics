import 'package:flutter/material.dart';
import 'package:w_phonics/widgets/custom_textfield.dart';

class PassswordTextfield extends StatefulWidget {
  const PassswordTextfield({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<PassswordTextfield> createState() => _PassswordTextfieldState();
}

class _PassswordTextfieldState extends State<PassswordTextfield> {
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      label: "Password",
      textColor: Colors.white,
      obscureText: _hidePassword,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _hidePassword = !_hidePassword;
          });
        },
        icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white60),
      ),
    );
  }
}
