import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class LogoutController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  logout(context) async {
    loading = true;
    notifyListeners();
    data = await LogoutLogic.logout();
    await const FlutterSecureStorage().deleteAll();
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
