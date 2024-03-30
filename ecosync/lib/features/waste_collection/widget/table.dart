import 'package:flutter/material.dart';

import '../../../models/waste_collection_model.dart';

class UserTableView extends StatefulWidget {
  const UserTableView(
      {super.key, required this.wasteCollection, required this.search});
  final List<WasteCollectionModel> wasteCollection;
  final TextEditingController search;

  @override
  State<UserTableView> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<UserTableView> {
  int? sortColumnIndex;
  bool isAscending = false;

  final columns = [
    'STS Id',
    'Vehicle Number',
    'Waste Volume',
    'Arrival Time',
    'Depertutre Time'
  ];
  @override
  void initState() {
    super.initState();
    widget.search.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    widget.search.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  List<WasteCollectionModel> getFilteredWasteCollection() {
    final query = widget.search.text.toLowerCase();
    return widget.wasteCollection.where((waste) {
      return waste.sts_id.toString().toLowerCase().contains(query) ||
          waste.vehicle_number.toLowerCase().contains(query) ||
          waste.volume_waste.toString().toLowerCase().contains(query) ||
          waste.arrival_time.toLowerCase().contains(query) ||
          waste.departure_time.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredWasteCollection = getFilteredWasteCollection();
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
        rows: getRows(filteredWasteCollection),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<WasteCollectionModel> wasteCollection) =>
      wasteCollection.map((WasteCollectionModel waste) {
        final cells = [
          DataCell(
            Text(waste.sts_id.toString()),
          ),
          DataCell(
            Text(waste.vehicle_number),
          ),
          DataCell(
            Text(waste.volume_waste.toString()),
          ),
          DataCell(
            Text(waste.arrival_time),
          ),
          DataCell(
            Text(waste.departure_time),
          )
        ];

        return DataRow(cells: cells);
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      // users.sort((user1, user2) =>
      // compareString(ascending, user1.firstName, user2.firstName));
    } else if (columnIndex == 1) {
      // users.sort((user1, user2) =>
      //     compareString(ascending, user1.lastName, user2.lastName));
    } else if (columnIndex == 2) {
      // users.sort((user1, user2) =>
      //     compareString(ascending, '${user1.age}', '${user2.age}'));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
