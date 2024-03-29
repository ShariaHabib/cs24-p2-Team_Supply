import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../business_logic/get_user_profile_logic.dart';
import '../../../models/models.dart';

class UserProfileController with ChangeNotifier {
  late UserProfileResponse data;
  bool loading = false;
  getUserData(context) async {
    loading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 5));
    String? token = await const FlutterSecureStorage().read(key: 'token');
    var x = await GetUserProfileLogic.getUser(token ?? '');
    data = x;
    loading = false;
    notifyListeners();
  }
}
