class HospitalModel {
  String title;
  String description;
  String phoneNumber;
  String address;
  String category;
  double long;
  double lat;
  String imgUrl;

  List<Review> reviews;
  HospitalModel(
      {this.title,
      this.description,
      this.phoneNumber,
      this.address,
      this.category,
      this.long,
      this.lat,
      this.reviews,
      this.imgUrl});
  factory HospitalModel.fromJson(Map<String, dynamic> parsedJson) {
    var reviews = parsedJson['reviews'] as List;
    List<Review> reviewList = reviews.map((i) => Review.fromJson(i)).toList();
    return HospitalModel(
        title: parsedJson["title"] ?? "",
        description: parsedJson["description"] ?? "",
        phoneNumber: parsedJson["phoneNumber"] ?? "",
        category: parsedJson["category"] ?? "",
        address: parsedJson["address"] ?? "",
        long: parsedJson['long'] ?? "",
        lat: parsedJson["lat"] ?? "",
        reviews: reviewList,
        imgUrl: parsedJson["url"] ?? "");
  }
}

class Review {
  String userName;
  String review;

  Review({this.userName, this.review});
  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return Review(
        userName: parsedJson['userName'] ?? "",
        review: parsedJson["review"] ?? "");
  }
}
