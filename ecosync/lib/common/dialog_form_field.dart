import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_dropdown_button.dart';
import 'custom_text_field.dart';

class DialogFormFiled extends StatefulWidget {
  const DialogFormFiled({
    super.key,
    required this.controller,
    required this.prefixText,
    this.hintText,
    this.isDropDown,
    this.isDateTime,
    this.data,
  });

  final TextEditingController controller;
  final String prefixText;
  final String? hintText;
  final bool? isDropDown;
  final bool? isDateTime;
  final Map<String, String>? data;
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
            flex: 3,
            child: Text(widget.prefixText,
                style: Theme.of(context).textTheme.bodyLarge)),
        const Spacer(flex: 1),
        if (widget.isDropDown != null)
          Expanded(
              flex: 5,
              child: CustomDropDownButton(
                data: widget.data ?? {},
                controller: widget.controller,
              )),
        if (widget.isDropDown == null && widget.isDateTime == null)
          Expanded(
            flex: 5,
            child: CustomTextField(
                controller: widget.controller, hintText: widget.hintText ?? ""),
          ),
        if (widget.isDateTime == true)
          Expanded(
            flex: 6,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: widget.hintText,
              ),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (date != null) {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    DateTime dateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );

                    widget.controller.text =
                        DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                  }
                }
              },
            ),
          ),
      ],
    );
  }
}
