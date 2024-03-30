import 'package:ecosync/constants/constants.dart';
import 'package:ecosync/features/manage_sts/controller/get_sts_controller.dart';
import 'package:ecosync/features/manage_sts/controller/update_sts_controller.dart';
import 'package:ecosync/features/manage_users/controller/update_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';

class EditSTS extends StatefulWidget {
  EditSTS(
      {super.key,
      required this.ward_no,
      required this.stsId,
      required this.capacity,
      required this.latitude,
      required this.longitude,
      this.manager});
  final int ward_no;
  final int stsId;
  final int capacity;
  final double latitude;
  final double longitude;
  final String? manager;

  @override
  State<EditSTS> createState() => _EditUserState();
}

class _EditUserState extends State<EditSTS> {
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _stsId = TextEditingController();
  final TextEditingController _capacity = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();

  @override
  void initState() {
    _wardNo.text = widget.ward_no.toString();
    _stsId.text = widget.stsId.toString();
    _capacity.text = widget.capacity.toString();
    _latitude.text = widget.latitude.toString();
    _longitude.text = widget.longitude.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UpdateUsersController ctrRegist = context.watch<UpdateUsersController>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      surfaceTintColor: Colors.white,
      child: Container(
        height: 464,
        width: 560,
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Update User",
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
              prefixText: "Ward No",
              // hintText: "User Id",
              readOnly: true,
            ),
            DialogFormFiled(
              controller: _stsId,
              prefixText: "STS ID",
              // hintText: "User Id",
              readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _capacity,
                prefixText: "Capacity",
                hintText: "Capacity"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _latitude,
              prefixText: "Latitude",
              hintText: "Latitude",
              // readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _longitude,
              prefixText: "Longitude",
              hintText: "Longitude",
              // readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: CustomFilledButton(
                    onPressed: () async {
                      await context.read<UpdateSTSController>().updateData(
                          context,
                          ward_no: int.parse(_wardNo.text),
                          stsId: int.parse(_wardNo.text),
                          capacity: int.parse(_capacity.text),
                          latitude: double.parse(_latitude.text),
                          longitude: double.parse(_longitude.text));
                      if (!ctrRegist.loading && context.mounted) {
                        customResponseDialog(context, "Update Successful", "")
                            .then((value) => context
                                .read<GetSTScontroller>()
                                .getData(context));
                      } else {
                        customResponseDialog(
                            context, "Update Failed", ctrRegist.data.message,
                            isError: true);
                      }
                    },
                    buttonText: "Update",
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
