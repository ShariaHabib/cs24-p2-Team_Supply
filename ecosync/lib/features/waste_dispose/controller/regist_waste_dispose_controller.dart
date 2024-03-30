import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/regist_waste_dispose_logic.dart';
import '../../../models/models.dart';

class RegistWasteDisposeController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  registData(context,
      {required String vehicle_number,
      required int volume_waste,
      required String arrival_time,
      required String departure_time}) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await ResgistWasteDisposeLogic.registData(
      token ?? '',
      vehicle_number: vehicle_number,
      volume_waste: volume_waste,
      arrival_time: arrival_time,
      departure_time: departure_time,
    );
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
