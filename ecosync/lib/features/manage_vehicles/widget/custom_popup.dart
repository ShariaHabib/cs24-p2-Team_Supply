import 'package:ecosync/constants/constants.dart';
import 'package:ecosync/features/manage_vehicles/controller/regist_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Map<String, String> data = {
    "Open Truck": "Open Truck",
    "Dump Truck": "Dump Truck",
    "Compactor": "Compactor",
    "Container Carrier": "Container Carrier"
  };
  @override
  Widget build(BuildContext context) {
    RegistVehicleController ctrRegist =
        context.watch<RegistVehicleController>();

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
              data: data,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: CustomFilledButton(
                    onPressed: () async {
                      await context.read<RegistVehicleController>().registData(
                          context,
                          _vehicleNumber.text,
                          _vehicleCapacity.text,
                          _loadedFuelCost.text,
                          _unloadedFuelCost.text,
                          _vehicleType.text);
                      if (!ctrRegist.loading &&
                          ctrRegist.success &&
                          context.mounted) {
                        customResponseDialog(context, "Registration Successful",
                            "Please ask the user to check their mail");
                      }
                    },
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
