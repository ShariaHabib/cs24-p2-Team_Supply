import 'package:ecosync/business_logic/register_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/models.dart';

class RegistVehicleController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  registData(context, vehicleNumber, capacity, fuelCostLoaded, fuelCostUnloaded,
      vechicleType, sts_id) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await RegisterVehicleLogic.registerVehicle(
        capacity: capacity,
        fuelCapacityLoaded: fuelCostLoaded,
        fuelCapacityUnloaded: fuelCostUnloaded,
        token: token ?? '',
        vechileNumber: vehicleNumber,
        vehicleType: vechicleType,
        sts_id: sts_id);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
