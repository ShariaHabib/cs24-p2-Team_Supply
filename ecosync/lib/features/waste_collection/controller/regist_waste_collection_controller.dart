import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/create_waste_collection_logic.dart';
import '../../../models/models.dart';

class RegistWasteCollectionController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  registData(
      context, vehicleNumber, volumeWaste, arrivalTime, departureTime) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await RegistWasteCollectionLogic.getWasteCollection(
        token ?? '', vehicleNumber, volumeWaste, arrivalTime, departureTime);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
