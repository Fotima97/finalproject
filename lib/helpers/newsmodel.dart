class NewsModel {
  String title;
  String news;
  String imgUrl;
  String date;

  NewsModel({this.title, this.news, this.imgUrl, this.date});
  factory NewsModel.fromJson(Map<String, dynamic> parsedJson) {
    return NewsModel(
            title: parsedJson["title"] ?? "",
            news: parsedJson['news'] ?? "",
            imgUrl: parsedJson['imgUrl'] ?? "",
            date: parsedJson['date']) ??
        "";
  }
}
