import 'package:ecosync/business_logic/get_waste_dispose_logic.dart';
import 'package:ecosync/constants/constants.dart';
import 'package:ecosync/features/waste_dispose/controller/get_waste_dispose_controller.dart';
import 'package:ecosync/features/waste_dispose/controller/regist_waste_dispose_controller.dart';
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
  final TextEditingController _arrivalTime = TextEditingController();
  final TextEditingController _departureTime = TextEditingController();
  final TextEditingController _volumeDispose = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrRegist = context.watch<RegistWasteDisposeController>();
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
                  "Waste Disposal",
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
              controller: _arrivalTime,
              prefixText: "Arrival Time",
              hintText: "Enter Arrival Time of Vehicle",
              isDateTime: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _departureTime,
              prefixText: "Departure Time",
              hintText: "Enter Departure Time of Vehicle",
              isDateTime: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _volumeDispose,
              prefixText: "Waste Disosed",
              hintText: "Enter Volume in Tons",
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                ctrRegist.loading
                    ? CircularProgressIndicator()
                    : Expanded(
                        flex: 2,
                        child: CustomFilledButton(
                          onPressed: () async {
                            await context
                                .read<RegistWasteDisposeController>()
                                .registData(
                                  context,
                                  vehicle_number: _vehicleNumber.text,
                                  volume_waste: int.parse(_volumeDispose.text),
                                  arrival_time: _arrivalTime.text,
                                  departure_time: _departureTime.text,
                                );
                            if (!ctrRegist.loading &&
                                ctrRegist.success &&
                                context.mounted) {
                              customResponseDialog(context,
                                      "Vehicle Registration Successful", "")
                                  .then((value) => context
                                      .read<GetWaasteDisposeController>()
                                      .getData(context));
                            } else {
                              customResponseDialog(
                                  context,
                                  "Vehicle Registration Failed",
                                  ctrRegist.data.message,
                                  isError: true);
                            }
                          },
                          buttonText: "Register",
                          filledColor: Theme.of(context).colorScheme.primary,
                          buttonTextColor:
                              Theme.of(context).colorScheme.onPrimary,
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
