import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../business_logic/waste_collection_logic.dart';
import '../../../models/waste_collection_model.dart';

class WasteCollectionController with ChangeNotifier {
  late List<WasteCollectionModel> data;

  bool loading = false;
  late bool success;

  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    var ct = await WasteCollectionLogic.getWasteCollection(token ?? '');
    data = ct.stsScheduleList;
    print(data);
    success = true;
    loading = false;
    notifyListeners();
  }
}
