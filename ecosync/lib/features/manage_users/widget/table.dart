import 'dart:math';

import 'package:ecosync/common/common.dart';
import 'package:ecosync/features/manage_users/widget/edit_user_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../controller/controller.dart';

class UserTableView extends StatefulWidget {
  const UserTableView({super.key, required this.users, required this.search});
  final List<User> users;
  final TextEditingController search;

  @override
  State<UserTableView> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<UserTableView> {
  int? sortColumnIndex;
  bool isAscending = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.search.addListener(_onSearchTextChanged);
    context.read<GetRolesController>().getData(context);
  }

  @override
  void dispose() {
    widget.search.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  List<User> getFilteredUsers() {
    final query = widget.search.text.toLowerCase();
    return widget.users.where((user) {
      return user.userName!.toLowerCase().contains(query) ||
          user.email!.toLowerCase().contains(query) ||
          user.userId.toString().contains(query);
    }).toList();
  }

  final columns = ['User Id', 'User Name', 'Email', 'Role', ''];

  @override
  Widget build(BuildContext context) {
    final filteredUsers = getFilteredUsers();
    DeleteUserController ctr = context.watch<DeleteUserController>();
    GetRolesController ctr2 = context.watch<GetRolesController>();
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 0,
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        dividerThickness: 0.5,
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        headingRowHeight: 40,
        headingRowColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.surfaceVariant),
        columns: getColumns(columns),
        rows: getRows(filteredUsers, ctr, ctr2),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<User> users, DeleteUserController ctr,
          GetRolesController ctr2) =>
      users.map((User user) {
        final cells = [
          DataCell(
            Text(user.userId.toString(), style: const TextStyle(fontSize: 10)),
          ),
          DataCell(
            Text(user.userName ?? ""),
          ),
          DataCell(
            Text(user.email ?? ""),
          ),
          DataCell(ctr2.loading
              ? const CircularProgressIndicator()
              : CustomDropDownButton(
                  controller: controller,
                  data: ctr2.data,
                  initialentry: ctr2.data.entries
                      .firstWhere((element) => element.value == user.userRole)
                      .key,
                  onChange: (roleId) async {
                    await context
                        .read<RoleUpdateController>()
                        .updateData(context, roleId, user.userId);
                  },
                )),
          DataCell(
            _buildActionButtons(user, ctr),
          ),
        ];

        return DataRow(cells: cells);
      }).toList();
  Widget _buildActionButtons(User user, DeleteUserController ctr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return EditUser(
                    email: user.email ?? "",
                    userId: user.userId ?? "",
                    userName: user.userName ?? "",
                  );
                });
          },
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {
            customDeleteDialog(context, () async {
              await context
                  .read<DeleteUserController>()
                  .deleteData(context, user.userId);

              if (!ctr.loading && ctr.success && context.mounted) {
                customResponseDialog(context, "User Deleted Successfully", "");
              } else {
                customResponseDialog(
                    context, "User Delete Failed", ctr.data.message,
                    isError: true);
              }
            });
          },
          icon: const Icon(Icons.delete_forever),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.users.sort((user1, user2) => compareString(
          ascending, user1.userId.toString(), user2.userId.toString()));
    } else if (columnIndex == 1) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.userName ?? "", user2.userName ?? ""));
    } else if (columnIndex == 2) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.email ?? "", user2.email ?? ""));
    } else if (columnIndex == 3) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.userRole ?? "", user2.userRole ?? ""));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
