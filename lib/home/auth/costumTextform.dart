import 'package:flutter/material.dart';
import 'package:todoapp/appcolors.dart';

typedef myVali = String? Function(String?);

class customTextform extends StatelessWidget {
  String label;
  TextEditingController controller;

  TextInputType KeyboardType;

  bool obscureText;
  myVali validator;

  customTextform({
    required this.label,
    required this.controller,
    required this.validator,
    this.KeyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appcolors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appcolors.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appcolors.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appcolors.redColor),
            ),
            errorMaxLines: 2),
        controller: controller,
        keyboardType: KeyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
