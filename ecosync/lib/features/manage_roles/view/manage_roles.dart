import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../widget/widgets.dart';

class ManageRoles extends StatefulWidget {
  const ManageRoles({super.key});

  @override
  State<ManageRoles> createState() => _ManageRolesState();
}

class _ManageRolesState extends State<ManageRoles> {
  final TextEditingController _role = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kDefaultPadding * 3),
            const BodyTitle(),
            const SizedBox(height: kDefaultPadding),
            Text("Roles", style: Theme.of(context).textTheme.headlineMedium),
            Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Divider()),
            CustomAddButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding * 0.5),
            const UserTableView(),
            const SizedBox(height: kDefaultPadding * 2),
            Text("Permissions",
                style: Theme.of(context).textTheme.headlineMedium),
            Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Divider()),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Row(
                children: [
                  // Expanded(
                  //     flex: 2, child: CustomDropDownButton(controller: _role)),
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 1,
                    child: CustomFilledButton(
                      onPressed: () {},
                      buttonText: "Update",
                      filledColor: Theme.of(context).colorScheme.primary,
                      buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            const PermissionCheckBox(),
          ],
        ),
      ),
    );
  }
}
