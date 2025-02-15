import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {super.key,
      required this.controller,
      required this.data,
      required this.initialentry,
      this.onChange});
  final TextEditingController controller;
  final Map<String, String> data;
  final String initialentry;
  final Function? onChange;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.initialentry;
    widget.controller.text = widget.data[dropdownValue] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(dropdownValue);
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
          items: widget.data.entries.map<DropdownMenuItem<String>>((emtry) {
            return DropdownMenuItem<String>(
              value: emtry.key,
              child: Text(emtry.value),
            );
          }).toList(),
          onChanged: (String? value) {
            widget.controller.text = widget.data[value] ?? "";
            if (widget.onChange != null) widget.onChange!(value);
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      ),
    );
  }
}
