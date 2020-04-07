import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  List<Notification> notification;

  NotificationModel({
    this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notification: List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
  };
}

class Notification {
  int id;
  String message;
  String link;
  String date;

  Notification({
    this.id,
    this.message,
    this.link,
    this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    message: json["message"],
    link: json["link"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "link": link,
    "date": date,
  };
}
