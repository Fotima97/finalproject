class HospitalModel {
  int hospitalId;
  String title;
  String description;
  String phoneNumber;
  String address;
  int categoryId;
  double long;
  double lat;
  String imgUrl;
  List<Review> reviews;

  HospitalModel(
      {this.hospitalId,
      this.title,
      this.description,
      this.phoneNumber,
      this.address,
      this.categoryId,
      this.long,
      this.lat,
      this.reviews,
      this.imgUrl});
  factory HospitalModel.fromJson(Map<String, dynamic> parsedJson) {
    var reviews = parsedJson['comments'] as List;
    List<Review> reviewList = reviews.map((i) => Review.fromJson(i)).toList();
    return HospitalModel(
        hospitalId: parsedJson['HospitalId'],
        title: parsedJson["HospitalName"] ?? "",
        description: parsedJson["Description"] ?? "",
        phoneNumber: parsedJson["PhoneNumber"] ?? "",
        categoryId: parsedJson["CategoryId"] ?? "",
        address: parsedJson["Address"] ?? "",
        long: parsedJson['Longitude'] ?? "",
        lat: parsedJson["Latitude"] ?? "",
        reviews: reviewList,
        imgUrl: parsedJson["ImgUrl"] ?? "");
  }
}

class Review {
  int reviewId;
  int hospitalId;
  String userName;
  String review;

  Review({this.reviewId, this.hospitalId, this.userName, this.review});
  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return Review(
        reviewId: parsedJson['CommentId'],
        hospitalId: parsedJson['HospitalId'],
        userName: parsedJson['UserName'] ?? "",
        review: parsedJson["CommentText"] ?? "");
  }
}
