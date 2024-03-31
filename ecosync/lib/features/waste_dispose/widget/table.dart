import 'package:ecosync/models/waste_dispose_model.dart';
import 'package:flutter/material.dart';

class WasteDisposeTable extends StatefulWidget {
  const WasteDisposeTable(
      {super.key, required this.wasteDispose, required this.search});
  final List<WasteDisposeModel> wasteDispose;
  final TextEditingController search;
  @override
  State<WasteDisposeTable> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<WasteDisposeTable> {
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    widget.search.addListener(_onSearchTextChanged); // Add listener to search
  }

  @override
  void dispose() {
    widget.search.removeListener(
        _onSearchTextChanged); // Remove listener to avoid memory leaks
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {}); // Trigger rebuild when search text changes
  }

  List<WasteDisposeModel> getFilteredWasteDispose() {
    final query = widget.search.text.toLowerCase();
    return widget.wasteDispose.where((waste) {
      // Perform filtering based on waste disposal attributes
      return waste.vehicle_number.toLowerCase().contains(query) ||
          waste.volume_waste.toString().toLowerCase().contains(query) ||
          waste.arrival_time.toLowerCase().contains(query) ||
          waste.departure_time.toLowerCase().contains(query);
    }).toList();
  }

  final columns = [
    'Vehicle Number',
    'Waste Volume',
    'Arrival Time',
    'Departure Time'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          columnSpacing: 20,
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
          rows: getRows(getFilteredWasteDispose())),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<WasteDisposeModel> vehicles) =>
      vehicles.map((WasteDisposeModel waste) {
        final cells = [
          DataCell(
            Text(waste.vehicle_number),
          ),
          DataCell(
            Text(waste.volume_waste.toString()),
          ),
          DataCell(
            Text(waste.arrival_time.toString()),
          ),
          DataCell(
            Text(waste.departure_time.toString()),
          ),
          // DataCell(
          //   _buildActionButtons(waste.vehicle_number, ctr),
          // ),
        ];

        return DataRow(cells: cells);
      }).toList();

  // Widget _buildActionButtons(vechicleNumber) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       IconButton(
  //         onPressed: () {},
  //         icon: const Icon(Icons.edit),
  //         color: Theme.of(context).colorScheme.primary,
  //       ),
  //       IconButton(
  //         onPressed: () {
  //           customDeleteDialog(context, () async {
  //             await context
  //                 .read<DeleteVehicleController>()
  //                 .deleteData(context, vechicleNumber);

  //             if (!ctr.loading && ctr.success && context.mounted) {
  //               customResponseDialog(context, "User Deleted Successfully", "");
  //             }
  //           });
  //         },
  //         icon: const Icon(Icons.delete_forever),
  //         color: Theme.of(context).colorScheme.primary,
  //       ),
  //     ],
  //   );
  // }

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
