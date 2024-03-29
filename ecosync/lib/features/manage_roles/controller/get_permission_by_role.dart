import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/get_permission_logic.dart';

class PermissionByRoleController with ChangeNotifier {
  // late PermissionListModel data;
  // late bool success;

  // bool loading = false;
  late String token;
  getPermission(context) async {
    // loading = true;
    token = await const FlutterSecureStorage().read(key: 'token') ?? "";
    // data = await GetPermissionListLogic.getPermissions(token ?? '');
    // success = data.success;
    // loading = false;
    notifyListeners();
  }
}
