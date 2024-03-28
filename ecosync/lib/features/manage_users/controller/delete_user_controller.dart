import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class DeleteUserController with ChangeNotifier {
  late RegistGeneralResponse data;
  late bool success;

  bool loading = false;

  deleteData(context, userId) async {
    loading = true;
    notifyListeners();
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await DeleteUserLogic.deleteUser(token ?? '', userId);
    success = data.success;
    loading = false;
    notifyListeners();
  }
}
