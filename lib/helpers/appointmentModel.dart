import 'dart:convert';

Appointment appointmentFromJson(String str) {
  final jsonData = json.decode(str);
  return Appointment.fromJson(jsonData);
}

String appointmentToJson(Appointment data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Appointment {
  int appointmentId;
  String doctorName;
  String appointmentDate;
  String appointmentTime;
  String appointmentPlace;
  String specialization;
  String appointmentNotes;
  bool alarm;
  String alarmTime;

  Appointment({
    this.appointmentId,
    this.doctorName,
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentPlace,
    this.specialization,
    this.appointmentNotes,
    this.alarm,
    this.alarmTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => new Appointment(
        appointmentId: json["AppointmentId"],
        doctorName: json["DoctorName"] ?? "",
        appointmentDate: json["AppointmentDate"] ?? "",
        appointmentTime: json["AppointmentTime"] ?? "",
        appointmentPlace: json["AppointmentPlace"] ?? "",
        specialization: json["Specialization"] ?? "",
        appointmentNotes: json["Notes"] ?? "",
        alarm: json["Alarm"] == 1 ? true : false,
        alarmTime: json["AlarmTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "DoctorName": doctorName,
        "AppointmentDate": appointmentDate,
        "AppointmentTime": appointmentTime,
        "AppointmentPlace": appointmentPlace,
        "Specialization": specialization,
        "Notes": appointmentNotes,
        "Alarm": alarm,
        "AlarmTime": alarmTime,
      };
}
