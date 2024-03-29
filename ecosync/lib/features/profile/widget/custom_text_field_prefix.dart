import 'package:flutter/material.dart';

class CustomTextFieldPrefix extends StatelessWidget {
  const CustomTextFieldPrefix({
    super.key,
    required this.controller,
    this.hintText,
    this.readOnly,
    required this.prefixText,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                Text(prefixText, style: Theme.of(context).textTheme.bodyLarge)),
        Expanded(
          flex: 2,
          child: TextField(
            readOnly: readOnly ?? false,
            controller: controller,
            decoration: InputDecoration(
              fillColor: readOnly ?? true ? Colors.grey[350] : Colors.white,
              hintText: hintText,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
