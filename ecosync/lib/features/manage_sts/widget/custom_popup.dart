import 'package:ecosync/constants/constants.dart';
import 'package:ecosync/features/manage_sts/controller/get_sts_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../controller/create_sts_controller.dart';
import '../controller/get_user_by_role_controller.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    context.read<GetUsersByRoleController>().getData(context, "2");
    super.initState();
  }

  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _capacity = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();
  final TextEditingController _manager = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetUsersByRoleController ctr = context.watch<GetUsersByRoleController>();
    RegistSTSController ctr2 = context.watch<RegistSTSController>();
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
            ctr.loading
                ? const CircularProgressIndicator()
                : DialogFormFiled(
                    controller: _manager,
                    data: ctr.data,
                    prefixText: "Select Manager",
                    isDropDown: true,
                  ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                ctr2.loading
                    ? CircularProgressIndicator()
                    : Expanded(
                        flex: 2,
                        child: CustomFilledButton(
                          onPressed: () async {
                            var man = ctr.data.entries
                                .firstWhere(
                                    (element) => element.value == _manager.text)
                                .key;
                            await context
                                .read<RegistSTSController>()
                                .registData(context,
                                    stsId: int.tryParse(_wardNo.text) ?? 0,
                                    ward_no: int.tryParse(_wardNo.text) ?? 0,
                                    capacity: int.tryParse(_capacity.text) ?? 0,
                                    latitude:
                                        double.tryParse(_latitude.text) ?? 0,
                                    longitude:
                                        double.tryParse(_longitude.text) ?? 0,
                                    manager: man);
                            if (!ctr2.loading &&
                                ctr2.success &&
                                context.mounted) {
                              customResponseDialog(context,
                                      "STS Registration Successful", "")
                                  .then((value) => context
                                      .read<GetSTScontroller>()
                                      .getData(context));
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
