import 'package:ecosync/features/manage_roles/controller/delete_rbac_roles_controller.dart';
import 'package:ecosync/models/rbac_roles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleTableView extends StatefulWidget {
  const RoleTableView({super.key, required this.roles});

  final List<RbacRolesModel> roles;
  @override
  State<RoleTableView> createState() => _RoleTableViewState();
}

class _RoleTableViewState extends State<RoleTableView> {
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
  }

  final columns = ['Role ID', 'Role', 'Assigned Permission', ''];

  @override
  Widget build(BuildContext context) {
    DeleteRbacController ctr = context.watch<DeleteRbacController>();
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 30,
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        dividerThickness: 0.5,
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        dataRowMaxHeight: 100,
        headingRowHeight: 40,
        headingRowColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.surfaceVariant),
        columns: getColumns(columns),
        rows: getRows(
          widget.roles,
          ctr,
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: null,
          ))
      .toList();

  List<DataRow> getRows(List<RbacRolesModel> roles, DeleteRbacController ctr) =>
      roles.map((RbacRolesModel role) {
        final cells = [
          DataCell(
            Text(role.role_id.toString()),
          ),
          DataCell(
            Text(role.role_name),
          ),
          DataCell(SingleChildScrollView(
              primary: false,
              child: SizedBox(
                  width: 350,
                  child: Text(role.permissions
                      .map((permission) => permission.permission_name)
                      .join(', '))))),
          DataCell(
            _buildActionButtons(role, ctr),
          ),
        ];

        return DataRow(cells: cells);
      }).toList();
  Widget _buildActionButtons(RbacRolesModel role, DeleteRbacController ctr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return EditUser(
            //         email: role.email ?? "",
            //         userId: role.userId ?? "",
            //         userName: role.userName,
            //       );
            //     });
          },
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {
            // customDeleteDialog(context, () async {
            //   await context
            //       .read<DeleteRbacController>()
            //       .deleteData(context, role.userId);

            //   if (!ctr.loading && ctr.success && context.mounted) {
            //     customResponseDialog(context, "role Deleted Successfully", "");
            //   }
            // });
          },
          icon: const Icon(Icons.delete_forever),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  // // void onSort(int columnIndex, bool ascending) {
  // //   if (columnIndex == 0) {
  // //     widget.users.sort((user1, user2) => compareString(
  // //         ascending, user1.userId.toString(), user2.userId.toString()));
  // //   } else if (columnIndex == 1) {
  // //     widget.users.sort((user1, user2) =>
  // //         compareString(ascending, user1.userName, user2.userName));
  // //   } else if (columnIndex == 2) {
  // //     widget.users.sort((user1, user2) =>
  // //         compareString(ascending, user1.email ?? "", user2.email ?? ""));
  // //   } else if (columnIndex == 3) {
  // //     widget.users.sort((user1, user2) =>
  // //         compareString(ascending, user1.userRole ?? "", user2.userRole ?? ""));
  // //   }
  // //   setState(() {
  // //     sortColumnIndex = columnIndex;
  // //     isAscending = ascending;
  // //   });
  // }
}
