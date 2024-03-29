import 'package:ecosync/features/manage_vehicles/controller/delete_vehicle_controller.dart';
import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';

class UserTableView extends StatefulWidget {
  const UserTableView({super.key, required this.vehicles});
  final List<Vehicle> vehicles;

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

  final columns = [
    'Vehicle Number',
    'Vehicle Capacity',
    'Fuel Capacity Loaded',
    'Fuel Capacity Unloaded',
    'Vehicle Type',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    DeleteVehicleController ctr = context.watch<DeleteVehicleController>();
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
          rows: getRows(widget.vehicles, ctr)),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Vehicle> vehicles, DeleteVehicleController ctr) =>
      vehicles.map((Vehicle vehicle) {
        final cells = [
          DataCell(
            Text(vehicle.vehicle_number),
          ),
          DataCell(
            Text(vehicle.capacity.toString()),
          ),
          DataCell(
            Text(vehicle.fuel_cost_loaded.toString()),
          ),
          DataCell(
            Text(vehicle.fuel_cost_unloaded.toString()),
          ),
          DataCell(
            Text(vehicle.vehicle_type),
          ),
          DataCell(
            _buildActionButtons(vehicle.vehicle_number, ctr),
          ),
        ];

        return DataRow(cells: cells);
      }).toList();

  Widget _buildActionButtons(vechicleNumber, DeleteVehicleController ctr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {
            customDeleteDialog(context, () async {
              await context
                  .read<DeleteVehicleController>()
                  .deleteData(context, vechicleNumber);

              if (!ctr.loading && ctr.success && context.mounted) {
                customResponseDialog(context, "User Deleted Successfully", "");
              }
            });
          },
          icon: const Icon(Icons.delete_forever),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

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
