import 'package:ecosync/business_logic/delete_sts_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/models.dart';

class DeleteSTSController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  deleteData(context, wardNo) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await DeleteSTSLogic.deleteSTS(token ?? '', wardNo);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
