// To parse this JSON data, do
//
//     final medications = medicationsFromJson(jsonString);

import 'dart:convert';

Medication medicationsFromJson(String str) {
  final jsonData = json.decode(str);
  return Medication.fromJson(jsonData);
}

String medicationsToJson(Medication data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Medication {
  int medId;
  String medName;
  String shape;
  int color;
  int dose;
  String units;
  int times;
  String startDate;
  String endDate;
  int duration;
  String notes;

  Medication(
      {this.medId,
      this.medName,
      this.shape,
      this.color,
      this.dose,
      this.units,
      this.times,
      this.startDate,
      this.endDate,
      this.duration,
      this.notes});

  factory Medication.fromJson(Map<String, dynamic> json) => new Medication(
      medId: json["MedId"],
      medName: json["MedName"] ?? "",
      shape: json["Shape"] ?? "",
      color: json["Color"],
      dose: json["Dose"] ?? 1,
      units: json["Units"] ?? "",
      times: json["Times"] ?? 1,
      startDate: json["StartDate"] ?? "",
      endDate: json["EndDate"] ?? "",
      duration: json["Duration"] ?? 1,
      notes: json["Notes"] ?? "...");

  Map<String, dynamic> toJson() => {
        "MedId": medId,
        "MedName": medName,
        "Shape": shape,
        "Color": color,
        "Dose": dose,
        "Units": units,
        "Times": times,
        "StartDate": startDate,
        "EndDate": endDate,
        "Duration": duration,
        "Notes": notes,
      };
}
