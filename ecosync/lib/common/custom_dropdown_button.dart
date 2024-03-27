import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
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
    return InputDecorator(
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
            );
  }
}