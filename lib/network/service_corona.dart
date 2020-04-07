import 'dart:convert';

import 'package:coronamonitorapps/models/corona_detail_province.dart';
import 'package:coronamonitorapps/models/corona_global.dart';
import 'package:coronamonitorapps/models/corona_indo.dart';
import 'package:http/http.dart' as http;

class ServiceCorona {
  static final String _baseUrl = 'https://api.codebanua.tech:8443';
  //end-point
  static String apiCovidGlobal = "/covid19";
  static String apiCovidIndo = "/covid19/id";
  static String apiCovidDetailProvince = "/covid19/id?provinsi=";
  //idProvince
  static int idKalsel = 22;

  Future<CoronaGlobal> getDataGlobal() async {
    final response = await http.get(_baseUrl + apiCovidGlobal);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      CoronaGlobal data = CoronaGlobal.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CoronaIndo> getDataIndo() async {
    final response = await http.get(_baseUrl + apiCovidIndo);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      CoronaIndo data = CoronaIndo.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CoronaDetailProvince> getDataDetailProvince(int id) async {
    final response = await http.get(_baseUrl + '$apiCovidDetailProvince$id');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      CoronaDetailProvince data = CoronaDetailProvince.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
