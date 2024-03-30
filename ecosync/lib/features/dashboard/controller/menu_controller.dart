import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentSelection = 0;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int get currentSelection => _currentSelection;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controlSelection(int index) {
    _currentSelection = index;
    notifyListeners();
  }
}
