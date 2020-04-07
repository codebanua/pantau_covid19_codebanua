import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:flutter/foundation.dart';

class RangeFilterChangeNotifier with ChangeNotifier {
  String selectedRangeChoice = 'Global';
  List listChoice = [
    {'name': 'Global', 'image': icGlobal},
    {'name': 'Indonesia', 'image': icIndonesia},
    {'name': 'Kalsel', 'image': icKalsel},
  ];

  void changeValue(String item) {
    selectedRangeChoice = item;
    notifyListeners();
  }
}
