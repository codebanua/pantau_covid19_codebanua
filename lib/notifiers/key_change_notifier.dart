import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageInfoChangeNotifier with ChangeNotifier {
  int _indexBottomNav = 0;
  int get indexBottomNav => _indexBottomNav;
  set indexBottomNav(int value) {
    _indexBottomNav = value;
    notifyListeners();
  }
}
