import 'dart:convert';

import 'package:coronamonitorapps/models/response_news.dart';
import 'package:http/http.dart' as http;


class ServiceNews {
  static final String _baseUrl = 'https://api.codebanua.tech:8443';

  Future<ResponseNews> getHoakNews(int page) async {
    final response = await http.get(_baseUrl + '/hoak?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getKemenkesNews(int page) async {
    final response = await http.get(_baseUrl + '/kemenkes?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getDetikNews(int page) async {
    final response = await http.get(_baseUrl + '/detik?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getLiputan6News(int page) async {
    final response = await http.get(_baseUrl + '/liputan6?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getKompasNews(int page) async {
    final response = await http.get(_baseUrl + '/kompas?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getTribunBjmNews(int page) async {
    final response = await http.get(_baseUrl + '/tribunnews?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseNews> getKanalKlmNews(int page) async {
    final response = await http.get(_baseUrl + '/kanalkalimantan?page=$page');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseNews data = ResponseNews.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
