import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {super.key, required this.controller, required this.data});
  final TextEditingController controller;
  final Map<String, String> data;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late Map<String, String> list;
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = list.entries.first.key;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
          focusColor: Colors.transparent,
          borderRadius: BorderRadius.circular(0),
          isExpanded: true,
          value: dropdownValue,
          items: list.entries.map<DropdownMenuItem<String>>((emtry) {
            return DropdownMenuItem<String>(
              value: emtry.key,
              child: Text(emtry.value),
            );
          }).toList(),
          onChanged: (String? value) {
            widget.controller.text = value.toString();
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      ),
    );
  }
}
