import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static Future<bool> savePref(String key, String value) {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setString(key, jsonEncode(value));
    });
  }

  static Future<dynamic> getPref(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var data = jsonDecode(prefs.getString(key) ?? 'false');
    return data;
  }
}