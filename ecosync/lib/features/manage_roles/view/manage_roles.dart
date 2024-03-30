import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../manage_users/controller/controller.dart';
import '../controller/rbac_roles_controller.dart';
import '../widget/widgets.dart';

class ManageRoles extends StatefulWidget {
  const ManageRoles({super.key});

  @override
  State<ManageRoles> createState() => _ManageRolesState();
}

class _ManageRolesState extends State<ManageRoles> {
  String dropdownValue = "1";

  @override
  void initState() {
    context.read<RbacRoleController>().getRbacRoles(context);
    context.read<GetRolesController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RbacRoleController ctr = context.watch<RbacRoleController>();
    GetRolesController ctr2 = context.watch<GetRolesController>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileCard(),
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
            ctr.loading
                ? const Center(child: CircularProgressIndicator())
                : RoleTableView(
                    roles: ctr.data.roleList,
                  ),
            const SizedBox(height: kDefaultPadding * 2),
            Text("Permissions",
                style: Theme.of(context).textTheme.headlineMedium),
            Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Divider()),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Row(
                children: [
                  ctr2.loading
                      ? const CircularProgressIndicator()
                      : Expanded(
                          flex: 2,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding * 0.5),
                                focusColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(0),
                                isExpanded: true,
                                value: dropdownValue,
                                items: ctr2.data.entries
                                    .map<DropdownMenuItem<String>>((emtry) {
                                  return DropdownMenuItem<String>(
                                    value: emtry.key,
                                    child: Text(emtry.value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 1,
                    child: CustomFilledButton(
                      onPressed: () {
                        setState(() {});
                      },
                      buttonText: "Update",
                      filledColor: Theme.of(context).colorScheme.primary,
                      buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            ctr2.loading
                ? CircularProgressIndicator()
                : PermissionCheckBox(roleId: dropdownValue),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
