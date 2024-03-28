import 'package:flutter/material.dart';

import '../../../models/models.dart';

class UserTableView extends StatefulWidget {
  const UserTableView({super.key, required this.users});
  final List<User> users;

  @override
  State<UserTableView> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<UserTableView> {
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
  }

  final columns = ['User Id', 'User Name', 'Email', 'Role', ''];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
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
        rows: getRows(widget.users),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<User> users) => users.map((User user) {
        final cells = [
          user.userId,
          user.email,
          user.userName,
          user.userRole,
          ""
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.userId, user2.userId));
    } else if (columnIndex == 1) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.userName, user2.userName));
    } else if (columnIndex == 2) {
      widget.users.sort(
          (user1, user2) => compareString(ascending, user1.email, user2.email));
    } else if (columnIndex == 3) {
      widget.users.sort((user1, user2) =>
          compareString(ascending, user1.userRole, user2.userRole));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
