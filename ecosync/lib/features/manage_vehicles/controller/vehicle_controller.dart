import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class GetVehiclesController with ChangeNotifier {
  List<Vehicle> data = [];

  bool loading = false;
  // late bool success;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<Vehicle> out = await GetVehicleListLogic.getVehicleList(token ?? '')
        .then((value) => value.vehicleList);
    data = out;
    loading = false;
    notifyListeners();
  }
}
