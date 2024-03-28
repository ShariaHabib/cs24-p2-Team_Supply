import 'package:ecosync/main.dart';
import 'package:ecosync/models/rbac_roles_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/rbac_roles_logic.dart';

class RbacRoleController with ChangeNotifier {
  late RbacRolesResponse data;
  late bool success;

  bool loading = false;

  getRbacRoles(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    data = await GetRbacRolesLogic.getRbacRole(token ?? '');
    success = data.success;

    loading = false;
    notifyListeners();
  }
}
