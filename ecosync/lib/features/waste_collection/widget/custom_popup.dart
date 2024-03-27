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
  final TextEditingController _stsId = TextEditingController();
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _arrivalTime = TextEditingController();
  final TextEditingController _departureTime = TextEditingController();
  final TextEditingController _volume = TextEditingController();

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
                  "Vehicle Registration",
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
                controller: _stsId,
                prefixText: "STS ID",
                hintText: "Enter STS ID"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _vehicleNumber,
                prefixText: "Vehicle Number",
                hintText: "Enter Vehicle Number"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _arrivalTime,
                prefixText: "Arrival Time",
                isDateTime: true,
                hintText: "Enter Arrival Time of Vehicle"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _departureTime,
              prefixText: "Departure Time",
              hintText: "Enter Departure Time of Vehicle",
              isDateTime: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _volume,
              prefixText: "Enter Volume of Waste Collected",
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
