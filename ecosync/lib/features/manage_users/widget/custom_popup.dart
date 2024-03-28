import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../controller/role_controller.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _role = TextEditingController();
  @override
  void initState() {
    context.read<GetRolesController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetRolesController ctr = context.watch<GetRolesController>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      surfaceTintColor: Colors.white,
      child: Container(
        height: 420,
        width: 400,
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User Registration",
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
                controller: _email, prefixText: "Email", hintText: "Email"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _password,
                prefixText: "Password",
                hintText: "Password"),
            const SizedBox(height: kDefaultPadding),
            ctr.loading
                ? const CircularProgressIndicator()
                : DialogFormFiled(
                    controller: _role,
                    roles: ctr.data,
                    prefixText: "Role",
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
