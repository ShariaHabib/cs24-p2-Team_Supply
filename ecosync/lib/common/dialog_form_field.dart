import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';

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
  Map<int, String> list = {
    4: "Unassigned",
    3: "Landfill Manager",
    2: "STS Manager",
    1: "System Admin "
  };
  late int dropdownValue;

  @override
  void initState() {
    dropdownValue = list.entries.first.key;
    super.initState();
  }

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
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.5),
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(0),
                  isExpanded: true,
                  value: dropdownValue,
                  items: list.entries.map<DropdownMenuItem<int>>((emtry) {
                    return DropdownMenuItem<int>(
                      value: emtry.key,
                      child: Text(emtry.value),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    widget.controller.text = value.toString();
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
            ),
          ),
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
