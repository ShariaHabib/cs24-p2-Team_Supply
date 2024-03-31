import 'package:ecosync/features/billings/widget/pdf_service.dart';
import 'package:ecosync/models/billings_model.dart';
import 'package:flutter/material.dart';

class BillingsTable extends StatefulWidget {
  BillingsTable({super.key, required this.billings});
  final List<BillingsModel> billings;
  @override
  State<BillingsTable> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<BillingsTable> {
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
  }

  final columns = [
    'Billing Slip ID',
    'Landfill Entry ID',
    'Weight of Waste',
    'Fuel Cost',
    'Generated Timestamp',
    ''
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
          rows: getRows(widget.billings)),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<BillingsModel> vehicles) =>
      vehicles.map((BillingsModel bill) {
        final cells = [
          DataCell(
            Text(bill.billing_slip_id.toString()),
          ),
          DataCell(
            Text(bill.landfill_entry_id.toString()),
          ),
          DataCell(
            Text(bill.weight_of_waste.toString()),
          ),
          DataCell(Text(bill.fuel_cost.toStringAsFixed(2))),
          DataCell(
            Text(bill.generated_timestamp),
          ),
          DataCell(IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              PdfService().printCustomersPdf(bill);
            },
          ))
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
