import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.persiantime,
    this.source,
    this.date,
  });

  int? id;
  String? title;
  String? description;
  String? image;
  String? persiantime;
  String? source;
  DateTime? date;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"] == null ? null : json["id"]!,
        title: json["title"] == null
            ? null
            : utf8.decode(json["title"]!.codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"]!.codeUnits),
        image: json["image"] == null ? null : json["image"]!,
        persiantime: json["persiantime"] == null
            ? null
            : utf8.decode(json["persiantime"]!.codeUnits),
        source: json["source"] == null
            ? null
            : utf8.decode(json["source"]!.codeUnits),
        date: json["date"] == null ? null : DateTime.parse(json["date"]!),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "title": title == null ? null : title!,
        "description": description == null ? null : description!,
        "image": image == null ? null : image!,
        "persiantime": persiantime == null ? null : persiantime!,
        "source": source == null ? null : source!,
        "date": date == null ? null : date!,
      };
}
