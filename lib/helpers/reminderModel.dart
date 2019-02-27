// To parse this JSON data, do
//
//     final reminders = remindersFromJson(jsonString);

import 'dart:convert';

Reminder remindersFromJson(String str) {
  final jsonData = json.decode(str);
  return Reminder.fromJson(jsonData);
}

String remindersToJson(Reminder data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Reminder {
  int reminderId;
  int medId;
  String notificationTime;
  bool token;

  Reminder({this.reminderId, this.medId, this.notificationTime, this.token});

  factory Reminder.fromJson(Map<String, dynamic> json) => new Reminder(
      reminderId: json["ReminderId"],
      medId: json["MedId"],
      notificationTime: json["NotificationTime"],
      token: json["Token"] == 1);

  Map<String, dynamic> toJson() => {
        "ReminderId": reminderId,
        "MedId": medId,
        "NotificationTime": notificationTime,
        "Token": token
      };
}
