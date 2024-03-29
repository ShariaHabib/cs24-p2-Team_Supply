import 'package:ecosync/business_logic/update_sts_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/models.dart';

class UpdateSTSController with ChangeNotifier {
  late RegistGeneralResponse data;
  //  late bool success;

  bool loading = false;

  updateData(context,
      {required int ward_no,
      required int stsId,
      required int capacity,
      required double latitude,
      required double longitude,
      String? manager}) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    var x = await UpdateSTSLogic.updateSTS(
      capacity: capacity,
      latitude: latitude,
      longitude: longitude,
      manager: manager,
      stsId: stsId,
      token: token ?? '',
      ward_no: ward_no,
    );
    data = x;
    print(data);
    loading = false;
    notifyListeners();
  }
}
