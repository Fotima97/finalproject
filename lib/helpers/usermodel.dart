class User {
  String fullName;
  String birthDate;
  String bloodType;
  String allergies;
  String email;
  User(
      {this.fullName,
      this.birthDate,
      this.bloodType,
      this.allergies,
      this.email});
  factory User.fromJson(Map<String, dynamic> parsedJson) => User(
      fullName: parsedJson["fullName"] ?? "",
      birthDate: parsedJson["birthDate"] ?? "",
      bloodType: parsedJson["bloodType"] ?? "",
      allergies: parsedJson["allergies"] ?? "",
      email: parsedJson["email"] ?? "");

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "birthDate": birthDate,
        "bloodType": bloodType,
        "allergies": allergies,
        "email": email
      };
}
