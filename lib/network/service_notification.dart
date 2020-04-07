import 'dart:convert';

import 'package:coronamonitorapps/models/notification_model.dart';
import 'package:http/http.dart' as http;

class ServiceNotification {
  static final String _baseUrl = 'http://api.codebanua.tech/notif';
//  static final String _baseUrl = 'http://192.168.43.244/notif';

  Future<NotificationModel> getDataNotif() async {
    final response = await http.get(_baseUrl + '/notif.json');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      NotificationModel data = NotificationModel.fromJson(json);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
