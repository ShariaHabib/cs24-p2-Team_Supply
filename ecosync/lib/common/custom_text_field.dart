import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.readOnly,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
      ),
    );
  }
}
