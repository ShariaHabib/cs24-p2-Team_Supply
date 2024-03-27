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
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _vehicleCapacity = TextEditingController();
  final TextEditingController _loadedFuelCost = TextEditingController();
  final TextEditingController _unloadedFuelCost = TextEditingController();
  final TextEditingController _vehicleType = TextEditingController();

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
                controller: _vehicleNumber,
                prefixText: "Vehicle Number",
                hintText: "Enter Vehicle Number"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _vehicleCapacity,
                prefixText: "Vechicle Capacity",
                hintText: "Enter Vehicle Capacity"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _loadedFuelCost,
                prefixText: "Fuel Cost(Loaded)",
                hintText: "Enter Loaded Fuel Cost"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _unloadedFuelCost,
                prefixText: "Fuel Cost(Unloaded)",
                hintText: "Enter Unloaded Fuel Cost"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _vehicleType,
              prefixText: "Vechicle Type",
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
