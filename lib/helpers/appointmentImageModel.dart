import 'dart:convert';

Images imagesFromJson(String str) {
  final jsonData = json.decode(str);
  return Images.fromJson(jsonData);
}

String imagesToJson(Images data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Images {
  int appointmentImageId;
  int appointmentId;
  String imageSrc;

  Images({
    this.appointmentImageId,
    this.appointmentId,
    this.imageSrc,
  });

  factory Images.fromJson(Map<String, dynamic> json) => new Images(
        appointmentImageId: json["AppointmentImageId"],
        appointmentId: json["AppointmentId"],
        imageSrc: json["ImageSrc"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentImageId": appointmentImageId,
        "AppointmentId": appointmentId,
        "ImageSrc": imageSrc,
      };
}
