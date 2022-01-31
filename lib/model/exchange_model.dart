// To parse this JSON data, do
//
//     final exchangeModel = exchangeModelFromJson(jsonString);

import 'dart:convert';

List<ExchangeModel> exchangeModelFromJson(String str) =>
    List<ExchangeModel>.from(
        json.decode(str).map((x) => ExchangeModel.fromJson(x)));

String exchangeModelToJson(List<ExchangeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExchangeModel {
  ExchangeModel({
    this.id,
    this.name,
    this.yearEstablished,
    this.country,
    this.description,
    this.url,
    this.image,
    this.hasTradingIncentive,
    this.trustScore,
    this.trustScoreRank,
    this.tradeVolume24HBtc,
    this.tradeVolume24HBtcNormalized,
  });

  String? id;
  String? name;
  int? yearEstablished;
  String? country;
  String? description;
  String? url;
  String? image;
  bool? hasTradingIncentive;
  int? trustScore;
  int? trustScoreRank;
  double? tradeVolume24HBtc;
  double? tradeVolume24HBtcNormalized;

  factory ExchangeModel.fromJson(Map<String, dynamic> json) => ExchangeModel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : json["name"]!,
        yearEstablished:
            json["year_established"] == null ? null : json["year_established"]!,
        country: json["country"] == null ? null : json["country"]!,
        description: json["description"] == null ? null : json["description"]!,
        url: json["url"] == null ? null : json["url"]!,
        image: json["image"] == null ? null : json["image"]!,
        hasTradingIncentive: json["has_trading_incentive"] == null
            ? null
            : json["has_trading_incentive"]!,
        trustScore: json["trust_score"] == null ? null : json["trust_score"]!,
        trustScoreRank:
            json["trust_score_rank"] == null ? null : json["trust_score_rank"]!,
        tradeVolume24HBtc: json["trade_volume_24h_btc"] == null
            ? null
            : json["trade_volume_24h_btc"]!.toDouble(),
        tradeVolume24HBtcNormalized:
            json["trade_volume_24h_btc_normalized"] == null
                ? null
                : json["trade_volume_24h_btc_normalized"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "year_established": yearEstablished == null ? null : yearEstablished!,
        "country": country == null ? null : country!,
        "description": description == null ? null : description!,
        "url": url == null ? null : url!,
        "image": image == null ? null : image!,
        "has_trading_incentive":
            hasTradingIncentive == null ? null : hasTradingIncentive!,
        "trust_score": trustScore == null ? null : trustScore!,
        "trust_score_rank": trustScoreRank == null ? null : trustScoreRank!,
        "trade_volume_24h_btc":
            tradeVolume24HBtc == null ? null : tradeVolume24HBtc!,
        "trade_volume_24h_btc_normalized": tradeVolume24HBtcNormalized == null
            ? null
            : tradeVolume24HBtcNormalized!,
      };
}
