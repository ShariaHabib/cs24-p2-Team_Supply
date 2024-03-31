import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../controller/regist_waste_collection_controller.dart';
import '../controller/waste_collection_controller.dart';

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
  final TextEditingController _volume = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegistWasteCollectionController ctr =
        context.watch<RegistWasteCollectionController>();
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
                  "Waste Collection",
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
              prefixText: "Volume",
              hintText: "Enter Volume in Tons",
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                ctr.loading
                    ? const CircularProgressIndicator()
                    : Expanded(
                        flex: 2,
                        child: CustomFilledButton(
                          onPressed: () async {
                            await context
                                .read<RegistWasteCollectionController>()
                                .registData(
                                    context,
                                    _vehicleNumber.text,
                                    int.parse(_volume.text),
                                    _arrivalTime.text,
                                    _departureTime.text);
                            if (!ctr.loading &&
                                ctr.success &&
                                context.mounted) {
                              customResponseDialog(
                                      context, "Data Added Successfully", "")
                                  .then((value) => context
                                      .read<WasteCollectionController>()
                                      .getData(context));
                            } else {
                              customResponseDialog(context, "Data Added Failed",
                                  ctr.data.message,
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
