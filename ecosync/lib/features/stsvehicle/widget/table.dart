import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';

class STSVehicleView extends StatefulWidget {
  const STSVehicleView(
      {super.key, required this.vehicles, required this.search});
  final List<Vehicle> vehicles;
  final TextEditingController search;

  @override
  State<STSVehicleView> createState() => _STSVehicleViewState();
}

class _STSVehicleViewState extends State<STSVehicleView> {
  int? sortColumnIndex;
  bool isAscending = false;

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

  final columns = [
    'Vehicle Number',
    'Vehicle Capacity',
    'Fuel Capacity Loaded',
    'Fuel Capacity Unloaded',
    'Vehicle Type'
  ];
  List<Vehicle> getFilteredVehicles() {
    final query = widget.search.text.toLowerCase();
    return widget.vehicles.where((vehicle) {
      final vehicleNumber = vehicle.vehicle_number.toLowerCase();
      final vehicleType = vehicle.vehicle_type.toLowerCase();
      final capacity = vehicle.capacity.toString().toLowerCase();
      final fuelCostLoaded = vehicle.fuel_cost_loaded.toString().toLowerCase();
      final fuelCostUnloaded =
          vehicle.fuel_cost_unloaded.toString().toLowerCase();

      return vehicleNumber.contains(query) ||
          vehicleType.contains(query) ||
          capacity.contains(query) ||
          fuelCostLoaded.contains(query) ||
          fuelCostUnloaded.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredVehicles = getFilteredVehicles();
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
          rows: getRows(filteredVehicles)),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Vehicle> vehicles) =>
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
