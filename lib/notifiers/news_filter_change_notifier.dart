import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:flutter/foundation.dart';

class NewsFilterChangeNotifier with ChangeNotifier {
  String selectedChoice = 'Hoak';
  List listChoice = [
    {'name': 'Hoak', 'image': icHoak},
    {'name': 'Kemenkes', 'image': icKemenkes},
    {'name': 'Tribun Banjarmasin', 'image': icTribun},
    {'name': 'Kanal Kalimantan', 'image': icKanalKlm},
    {'name': 'Detik', 'image': icDetik},
    {'name': 'Liputan6', 'image': icLiputan6},
    {'name': 'Kompas', 'image': icKompas},
  ];

  void changeValue(String item) {
    selectedChoice = item;
    notifyListeners();
  }
}
