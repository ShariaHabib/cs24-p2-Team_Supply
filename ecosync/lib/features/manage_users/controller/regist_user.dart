import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class RegistUserController with ChangeNotifier {
  late RegistGeneralResponse data;

  bool loading = false;

  getData(context, userName, email, password, userRole) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await RegistUserLogic.registUser(
        token ?? '', userName, email, password, userRole);
    print(data);
    loading = false;
    notifyListeners();
  }
}
