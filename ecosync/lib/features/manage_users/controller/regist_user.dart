import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class RegistUserController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  registData(context, userName, email, password, userRole) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await RegistUserLogic.registUser(
        token ?? '', userName, email, password, userRole);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
