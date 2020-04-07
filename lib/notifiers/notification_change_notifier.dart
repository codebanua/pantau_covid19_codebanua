import 'dart:convert';

import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:coronamonitorapps/helper/pref_helper.dart';
import 'package:coronamonitorapps/models/notification_model.dart';
import 'package:coronamonitorapps/network/service_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationChangeNotifier with ChangeNotifier {

  ServiceNotification _service = ServiceNotification();
  bool _isFetching;

  bool get isFetching => _isFetching;

  NotificationModel dataNotif;

  Future<void> getDataNotif() async {
    _isFetching = true;
    notifyListeners();
    dataNotif = await _service.getDataNotif();
    _isFetching = false;
    notifyListeners();
  }

  Map _notifPref;

  Map get notifPref => _notifPref;

  Future<Map> getNotifPref() async {
    await PrefHelper.getPref(AppConst.notifPref).then((result) {
      _notifPref = jsonDecode(result);
    });
    notifyListeners();
    return _notifPref;
  }

  void setNotifPref(String value) async {
    _notifPref = jsonDecode(value);
    await PrefHelper.savePref(AppConst.notifPref, value).then((result) {
    });
    notifyListeners();
  }
}
