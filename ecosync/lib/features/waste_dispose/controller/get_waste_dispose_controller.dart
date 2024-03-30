import 'package:ecosync/business_logic/get_waste_dispose_logic.dart';
import 'package:ecosync/models/waste_dispose_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetWaasteDisposeController with ChangeNotifier {
  List<WasteDisposeModel> data = [];

  bool loading = false;
  getData(context) async {
    loading = true;
    String? token = await const FlutterSecureStorage().read(key: 'token');
    List<WasteDisposeModel> out =
        await GetWasteDisposeListLogic.getWasteDisposeList(token ?? '')
            .then((value) => value.landfillEntryList);
    data = out;
    loading = false;
    notifyListeners();
  }
}
