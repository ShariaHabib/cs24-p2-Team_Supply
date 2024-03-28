import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class GetRolesController with ChangeNotifier {
  Map<String, String> data = {};

  bool loading = false;
  // late bool success;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<Role> out =
        await GetRoleLogic.getRole(token ?? '').then((value) => value.roleList);
    for (Role x in out) {
      data[x.roleName] = x.roleName;
    }
    loading = false;
    notifyListeners();
  }
}
