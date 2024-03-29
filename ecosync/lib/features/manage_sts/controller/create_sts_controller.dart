import 'package:ecosync/business_logic/regist_sts_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/models.dart';

class RegistSTSController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  registData(context,
      {required int ward_no,
      required int stsId,
      required int capacity,
      required double latitude,
      required double longitude,
      String? manager}) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await RegistSTSLogic.registSTS(
      token: token ?? '',
      ward_no: ward_no,
      stsId: stsId,
      latitude: latitude,
      longitude: longitude,
      manager: manager,
      capacity: capacity,
    );
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
