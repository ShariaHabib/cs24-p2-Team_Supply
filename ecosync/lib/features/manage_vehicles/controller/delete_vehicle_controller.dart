import 'package:ecosync/business_logic/delete_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/models.dart';

class DeleteVehicleController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  deleteData(context, vehicleNumber) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await DeleteVehicleLogic.deleteVehicle(token ?? '', vehicleNumber);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
