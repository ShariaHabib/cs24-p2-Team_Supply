import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/business_logic.dart';
import '../../../models/models.dart';

class GetRolesController with ChangeNotifier {
  late List<Role> data;

  bool loading = false;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data =
        await GetRoleLogic.getRole(token ?? '').then((value) => value.roleList);
    print(data);
    loading = false;
    notifyListeners();
  }
}
