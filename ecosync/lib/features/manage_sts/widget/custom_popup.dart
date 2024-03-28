import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _capacity = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();
  final TextEditingController _manager = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      surfaceTintColor: Colors.white,
      child: Container(
        height: 600,
        width: 450,
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "STS Registration",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            DialogFormFiled(
                controller: _wardNo,
                prefixText: "Ward No.",
                hintText: "Enter Ward Number"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _capacity,
                prefixText: "STS Capacity",
                hintText: "Enter STS Capacity"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _latitude,
                prefixText: "Latitude",
                hintText: "Enter Latitude"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _longitude,
                prefixText: "Longitude",
                hintText: "Enter Longitude"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _manager,
              prefixText: "Select Manager",
              isDropDown: true,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: CustomFilledButton(
                    onPressed: () {},
                    buttonText: "Register",
                    filledColor: Theme.of(context).colorScheme.primary,
                    buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
