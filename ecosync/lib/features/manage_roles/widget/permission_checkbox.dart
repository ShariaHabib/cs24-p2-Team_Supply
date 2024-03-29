import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/get_permissions_by_role.dart';
import '../../../business_logic/update_permissions.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../controller/get_permission_by_role.dart';
import '../controller/get_permission_controller.dart';

class PermissionCheckBox extends StatefulWidget {
  const PermissionCheckBox({super.key, required this.roleId});
  final String roleId;

  @override
  State<PermissionCheckBox> createState() => _PermissionCheckBoxState();
}

class _PermissionCheckBoxState extends State<PermissionCheckBox> {
  @override
  void initState() {
    context.read<PermissionController>().getPermission(context);
    context.read<PermissionByRoleController>().getPermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PermissionController ctr = context.watch<PermissionController>();
    return Container(
      constraints: const BoxConstraints(maxWidth: 700, maxHeight: 350),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ctr.loading
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder(
                future: GetPermissionByRoleListLogic.getPermissions(
                    context.read<PermissionByRoleController>().token,
                    widget.roleId),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    List<PermissionModel>? alldata = snap.data?.permissionList;

                    List<bool> isChecked = List.generate(
                        ctr.data.permissionList.length + 1,
                        (index) =>
                            alldata?.any(
                                (element) => element.permission_id == index) ??
                            false);

                    return NewWidget(
                      ctr: ctr,
                      isChecked: isChecked,
                      roleId: widget.roleId,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
    required this.ctr,
    required this.isChecked,
    required this.roleId,
  });

  final PermissionController ctr;
  final List<bool> isChecked;
  final String roleId;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 5,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: widget.ctr.data.permissionList.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Checkbox(
              value: widget.isChecked[index + 1],
              onChanged: (bool? value) async {
                setState(() {
                  widget.isChecked[index + 1] = !widget.isChecked[index + 1];
                });
                await UpdatePermissionLogic.updatePermissions(
                    context.read<PermissionByRoleController>().token,
                    widget.roleId,
                    widget.isChecked
                        .asMap()
                        .entries
                        .where((entry) => entry.value == true)
                        .map((entry) => entry.key)
                        .toList());
                print("SUCCESS");
              },
            ),
            Text(widget.ctr.data.permissionList[index].permission_name),
          ],
        );
      },
    );
  }
}
