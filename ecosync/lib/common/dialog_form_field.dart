import 'package:flutter/material.dart';

import 'custom_dropdown_button.dart';
import 'custom_text_field.dart';

class DialogFormFiled extends StatefulWidget {
  const DialogFormFiled({
    super.key,
    required this.controller,
    required this.prefixText,
    this.hintText,
    this.isDropDown,
  });

  final TextEditingController controller;
  final String prefixText;
  final String? hintText;
  final bool? isDropDown;

  @override
  State<DialogFormFiled> createState() => _DialogFormFiledState();
}

class _DialogFormFiledState extends State<DialogFormFiled> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: Text(widget.prefixText,
                style: Theme.of(context).textTheme.bodyLarge)),
        if (widget.isDropDown != null)
          Expanded(
              flex: 3,
              child: CustomDropDownButton(
                controller: widget.controller,
              )),
        if (widget.isDropDown == null)
          Expanded(
            flex: 3,
            child: CustomTextField(
                controller: widget.controller, hintText: widget.hintText ?? ""),
          )
      ],
    );
  }
}
