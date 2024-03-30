import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/get_user_by_role.dart';

class GetUsersByRoleController with ChangeNotifier {
  Map<String, String> data = {};
  late bool success;

  bool loading = false;

  getData(context, roleId) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    var out = await GetUserByRoleLogic.getUser(token ?? '', roleId);
    for (User x in out.userList) {
      data[x.userId.toString()] = x.userName ?? "";
    }
    success = out.success;
    loading = false;
    notifyListeners();
  }
}
