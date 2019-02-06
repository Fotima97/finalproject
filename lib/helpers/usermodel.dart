class UserModel {
  String fullName;
  String birthDate;
  String bloodType;
  String allergies;
  String email;
  UserModel(
      {this.fullName,
      this.birthDate,
      this.bloodType,
      this.allergies,
      this.email});
  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        fullName: parsedJson["fullName"] ?? "",
        birthDate: parsedJson["birthDate"] ?? "",
        bloodType: parsedJson["bloodType"] ?? "",
        allergies: parsedJson["allergies"] ?? "",
        email: parsedJson["email"] ?? "");
  }
}
