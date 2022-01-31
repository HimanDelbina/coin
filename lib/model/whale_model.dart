import 'dart:convert';

List<WhaleModel> whaleModelFromJson(String str) =>
    List<WhaleModel>.from(json.decode(str).map((x) => WhaleModel.fromJson(x)));

String whaleModelToJson(List<WhaleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WhaleModel {
  WhaleModel({
    this.id,
    this.englishname,
    this.persianame,
    this.coinnumber,
    this.sender,
    this.reciver,
    this.persiantime,
    this.date,
  });

  int? id;
  String? englishname;
  String? persianame;
  String? coinnumber;
  String? sender;
  String? reciver;
  String? persiantime;
  DateTime? date;

  factory WhaleModel.fromJson(Map<String, dynamic> json) => WhaleModel(
        id: json["id"]! == null ? null : json["id"],
        englishname: json["englishname"]! == null
            ? null
            : utf8.decode(json["englishname"].codeUnits),
        persianame: json["persianame"]! == null
            ? null
            : utf8.decode(json["persianame"].codeUnits),
        coinnumber: json["coinnumber"]! == null
            ? null
            : utf8.decode(json["coinnumber"].codeUnits),
        sender: json["sender"]! == null
            ? null
            : utf8.decode(json["sender"].codeUnits),
        reciver: json["reciver"]! == null
            ? null
            : utf8.decode(json["reciver"].codeUnits),
        persiantime: json["persiantime"]! == null
            ? null
            : utf8.decode(json["persiantime"].codeUnits),
        date: json["date"]! == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "englishname": englishname == null ? null : englishname!,
        "persianame": persianame == null ? null : persianame!,
        "coinnumber": coinnumber == null ? null : coinnumber!,
        "sender": sender == null ? null : sender!,
        "reciver": reciver == null ? null : reciver!,
        "persiantime": persiantime == null ? null : persiantime!,
        "date": date == null ? null : date!.toIso8601String(),
      };
}
