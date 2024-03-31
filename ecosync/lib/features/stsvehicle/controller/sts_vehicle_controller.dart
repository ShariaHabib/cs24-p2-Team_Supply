import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/get_sts_vehicles.dart';
import '../../../models/models.dart';

class STSVehicleController with ChangeNotifier {
  List<Vehicle> data = [];

  bool loading = false;
  // late bool success;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<Vehicle> out = await GetSTSVehicleListLogic.getVehicleList(token ?? '')
        .then((value) => value.vehiclesList);
    data = out;
    loading = false;
    notifyListeners();
  }
}
