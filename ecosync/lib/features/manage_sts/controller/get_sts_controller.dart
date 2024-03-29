import 'package:ecosync/business_logic/get_sts_logic.dart';
import 'package:ecosync/models/sts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetSTScontroller with ChangeNotifier {
  List<STS> data = [];

  bool loading = false;
  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<STS> out =
        await GetSTSlogic.getSTS(token ?? '').then((value) => value.stsList);
    data = out;
    loading = false;
    notifyListeners();
  }
}
