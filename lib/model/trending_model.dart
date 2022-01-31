// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

TrendingModel trendingModelFromJson(String str) =>
    TrendingModel.fromJson(json.decode(str));

String trendingModelToJson(TrendingModel data) => json.encode(data.toJson());

class TrendingModel {
  TrendingModel({
    this.coins,
    this.exchanges,
  });

  List<Coin>? coins;
  List<dynamic>? exchanges;

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        coins: json["coins"] == null
            ? null
            : List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
        exchanges: json["exchanges"] == null
            ? null
            : List<dynamic>.from(json["exchanges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "coins": coins == null
            ? null
            : List<dynamic>.from(coins!.map((x) => x.toJson())),
        "exchanges": exchanges == null
            ? null
            : List<dynamic>.from(exchanges!.map((x) => x)),
      };
}

class Coin {
  Coin({
    this.item,
  });

  Item? item;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item!.toJson(),
      };
}

class Item {
  Item({
    this.id,
    this.coinId,
    this.name,
    this.symbol,
    this.marketCapRank,
    this.thumb,
    this.small,
    this.large,
    this.slug,
    this.priceBtc,
    this.score,
  });

  String? id;
  int? coinId;
  String? name;
  String? symbol;
  int? marketCapRank;
  String? thumb;
  String? small;
  String? large;
  String? slug;
  double? priceBtc;
  int? score;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"]!,
        coinId: json["coin_id"] == null ? null : json["coin_id"]!,
        name: json["name"] == null ? null : json["name"]!,
        symbol: json["symbol"] == null ? null : json["symbol"]!,
        marketCapRank:
            json["market_cap_rank"] == null ? null : json["market_cap_rank"]!,
        thumb: json["thumb"] == null ? null : json["thumb"]!,
        small: json["small"] == null ? null : json["small"]!,
        large: json["large"] == null ? null : json["large"]!,
        slug: json["slug"] == null ? null : json["slug"]!,
        priceBtc:
            json["price_btc"] == null ? null : json["price_btc"]!.toDouble(),
        score: json["score"] == null ? null : json["score"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "coin_id": coinId == null ? null : coinId!,
        "name": name == null ? null : name!,
        "symbol": symbol == null ? null : symbol!,
        "market_cap_rank": marketCapRank == null ? null : marketCapRank!,
        "thumb": thumb == null ? null : thumb!,
        "small": small == null ? null : small!,
        "large": large == null ? null : large!,
        "slug": slug == null ? null : slug!,
        "price_btc": priceBtc == null ? null : priceBtc!,
        "score": score == null ? null : score!,
      };
}
