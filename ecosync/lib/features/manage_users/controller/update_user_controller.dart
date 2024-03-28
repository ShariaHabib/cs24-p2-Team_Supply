import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class UpdateUsersController with ChangeNotifier {
  late RegistGeneralResponse data;
  //  late bool success;

  bool loading = false;

  updateData(context, String name, String userId) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    var x = await UpdateUserLogic.updateUser(token ?? '', name, userId);
    data = x;
    print(data);
    loading = false;
    notifyListeners();
  }
}
