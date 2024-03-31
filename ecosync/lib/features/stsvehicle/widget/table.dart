import 'package:flutter/material.dart';
import 'package:ecosync/models/models.dart';

class STSVehicleView extends StatefulWidget {
  const STSVehicleView(
      {super.key, required this.vehicles, required this.search});
  final List<Vehicle> vehicles;
  final TextEditingController search;

  @override
  State<STSVehicleView> createState() => _STSVehicleViewState();
}

class _STSVehicleViewState extends State<STSVehicleView> {
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
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredVehicles.length,
        itemBuilder: (context, index) {
          final vehicle = filteredVehicles[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                  'Vehicle Number : ${vehicle.vehicle_number}    -     Capacity: ${vehicle.capacity}'),
              children: <Widget>[
                ListTile(
                  title:
                      Text('Fuel Capacity Loaded: ${vehicle.fuel_cost_loaded}'),
                ),
                ListTile(
                  title: Text(
                      'Fuel Capacity Unloaded: ${vehicle.fuel_cost_unloaded}'),
                ),
                ListTile(
                  title: Text('Vehicle Type: ${vehicle.vehicle_type}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
