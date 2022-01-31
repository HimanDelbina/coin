// To parse this JSON data, do
//
//     final selectCoinModel = selectCoinModelFromJson(jsonString);

import 'dart:convert';

SelectCoinModel selectCoinModelFromJson(String str) =>
    SelectCoinModel.fromJson(json.decode(str));

String selectCoinModelToJson(SelectCoinModel data) =>
    json.encode(data.toJson());

class SelectCoinModel {
  SelectCoinModel({
    this.id,
    this.symbol,
    this.name,
    // this.assetPlatformId,
    // this.platforms,
    // this.blockTimeInMinutes,
    // this.hashingAlgorithm,
    // this.categories,
    // this.publicNotice,
    // this.additionalNotices,
    // this.description,
    // this.links,
    this.image,
    // this.countryOrigin,
    this.genesisDate,
    // this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    this.marketCapRank,
    // this.coingeckoRank,
    // this.coingeckoScore,
    // this.developerScore,
    this.communityScore,
    // this.liquidityScore,
    // this.publicInterestScore,
    this.marketData,
    // this.communityData,
    // this.developerData,
    // this.publicInterestStats,
    // this.statusUpdates,
    // this.lastUpdated,
    // this.tickers,
  });

  String? id;
  String? symbol;
  String? name;
  // dynamic? assetPlatformId;
  // Platforms? platforms;
  // int? blockTimeInMinutes;
  // String? hashingAlgorithm;
  // List<String>? categories;
  // dynamic? publicNotice;
  // List<dynamic>? additionalNotices;
  // Description? description;
  // Links? links;
  Image? image;
  // String? countryOrigin;
  DateTime? genesisDate;
  // double? sentimentVotesUpPercentage;
  double? sentimentVotesDownPercentage;
  int? marketCapRank;
  // int? coingeckoRank;
  // double? coingeckoScore;
  // double? developerScore;
  double? communityScore;
  // double? liquidityScore;
  // int? publicInterestScore;
  MarketData? marketData;
  // CommunityData? communityData;
  // DeveloperData? developerData;
  // PublicInterestStats? publicInterestStats;
  // List<dynamic>? statusUpdates;
  // DateTime? lastUpdated;
  // List<Ticker>? tickers;

  factory SelectCoinModel.fromJson(Map<String, dynamic> json) =>
      SelectCoinModel(
        // id: json["id"] == null ? null : idValues.map[json["id"]],
        symbol: json["symbol"] == null ? null : json["symbol"]!,
        name: json["name"] == null ? null : json["name"]!,
        // assetPlatformId: json["asset_platform_id"],
        // platforms: json["platforms"] == null ? null : Platforms.fromJson(json["platforms"]),
        // blockTimeInMinutes: json["block_time_in_minutes"] == null ? null : json["block_time_in_minutes"],
        // hashingAlgorithm: json["hashing_algorithm"] == null ? null : json["hashing_algorithm"],
        // categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
        // publicNotice: json["public_notice"],
        // additionalNotices: json["additional_notices"] == null ? null : List<dynamic>.from(json["additional_notices"].map((x) => x)),
        // description: json["description"] == null ? null : Description.fromJson(json["description"]),
        // links: json["links"] == null ? null : Links.fromJson(json["links"]),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        // countryOrigin: json["country_origin"] == null ? null : json["country_origin"],
        genesisDate: json["genesis_date"] == null
            ? null
            : DateTime.parse(json["genesis_date"]),
        // sentimentVotesUpPercentage: json["sentiment_votes_up_percentage"] == null ? null : json["sentiment_votes_up_percentage"].toDouble(),
        sentimentVotesDownPercentage:
            json["sentiment_votes_down_percentage"] == null
                ? null
                : json["sentiment_votes_down_percentage"]!.toDouble(),
        marketCapRank:
            json["market_cap_rank"] == null ? null : json["market_cap_rank"]!,
        // coingeckoRank: json["coingecko_rank"] == null ? null : json["coingecko_rank"],
        // coingeckoScore: json["coingecko_score"] == null ? null : json["coingecko_score"].toDouble(),
        // developerScore: json["developer_score"] == null ? null : json["developer_score"].toDouble(),
        communityScore: json["community_score"] == null
            ? null
            : json["community_score"]!.toDouble(),
        // liquidityScore: json["liquidity_score"] == null ? null : json["liquidity_score"].toDouble(),
        // publicInterestScore: json["public_interest_score"] == null ? null : json["public_interest_score"],
        marketData: json["market_data"] == null
            ? null
            : MarketData.fromJson(json["market_data"]),
        // communityData: json["community_data"] == null ? null : CommunityData.fromJson(json["community_data"]),
        // developerData: json["developer_data"] == null ? null : DeveloperData.fromJson(json["developer_data"]),
        // publicInterestStats: json["public_interest_stats"] == null ? null : PublicInterestStats.fromJson(json["public_interest_stats"]),
        // statusUpdates: json["status_updates"] == null ? null : List<dynamic>.from(json["status_updates"].map((x) => x)),
        // lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
        // tickers: json["tickers"] == null ? null : List<Ticker>.from(json["tickers"].map((x) => Ticker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "id": id == null ? null : idValues.reverse[id],
        "symbol": symbol == null ? null : symbol,
        "name": name == null ? null : name,
        // "asset_platform_id": assetPlatformId,
        // "platforms": platforms == null ? null : platforms.toJson(),
        // "block_time_in_minutes": blockTimeInMinutes == null ? null : blockTimeInMinutes,
        // "hashing_algorithm": hashingAlgorithm == null ? null : hashingAlgorithm,
        // "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
        // "public_notice": publicNotice,
        // "additional_notices": additionalNotices == null ? null : List<dynamic>.from(additionalNotices.map((x) => x)),
        // "description": description == null ? null : description.toJson(),
        // "links": links == null ? null : links.toJson(),
        "image": image == null ? null : image!.toJson(),
        // "country_origin": countryOrigin == null ? null : countryOrigin,
        "genesis_date": genesisDate == null
            ? null
            : "${genesisDate!.year.toString().padLeft(4, '0')}-${genesisDate!.month.toString().padLeft(2, '0')}-${genesisDate!.day.toString().padLeft(2, '0')}",
        // "sentiment_votes_up_percentage": sentimentVotesUpPercentage == null ? null : sentimentVotesUpPercentage,
        "sentiment_votes_down_percentage": sentimentVotesDownPercentage == null
            ? null
            : sentimentVotesDownPercentage!,
        "market_cap_rank": marketCapRank == null ? null : marketCapRank!,
        // "coingecko_rank": coingeckoRank == null ? null : coingeckoRank,
        // "coingecko_score": coingeckoScore == null ? null : coingeckoScore,
        // "developer_score": developerScore == null ? null : developerScore,
        "community_score": communityScore == null ? null : communityScore!,
        // "liquidity_score": liquidityScore == null ? null : liquidityScore,
        // "public_interest_score": publicInterestScore == null ? null : publicInterestScore,
        "market_data": marketData == null ? null : marketData!.toJson(),
        // "community_data": communityData == null ? null : communityData.toJson(),
        // "developer_data": developerData == null ? null : developerData.toJson(),
        // "public_interest_stats": publicInterestStats == null ? null : publicInterestStats.toJson(),
        // "status_updates": statusUpdates == null ? null : List<dynamic>.from(statusUpdates.map((x) => x)),
        // "last_updated": lastUpdated == null ? null : lastUpdated.toIso8601String(),
        // "tickers": tickers == null ? null : List<dynamic>.from(tickers.map((x) => x.toJson())),
      };
}

// class CommunityData {
//   CommunityData({
//     this.facebookLikes,
//     this.twitterFollowers,
//     this.redditAveragePosts48H,
//     this.redditAverageComments48H,
//     this.redditSubscribers,
//     this.redditAccountsActive48H,
//     this.telegramChannelUserCount,
//   });

//   dynamic? facebookLikes;
//   int? twitterFollowers;
//   double? redditAveragePosts48H;
//   double? redditAverageComments48H;
//   int? redditSubscribers;
//   int? redditAccountsActive48H;
//   dynamic? telegramChannelUserCount;

//     factory CommunityData.fromJson(Map<String, dynamic> json) => CommunityData(
//         facebookLikes: json["facebook_likes"],
//         twitterFollowers: json["twitter_followers"] == null ? null : json["twitter_followers"],
//         redditAveragePosts48H: json["reddit_average_posts_48h"] == null ? null : json["reddit_average_posts_48h"],
//         redditAverageComments48H: json["reddit_average_comments_48h"] == null ? null : json["reddit_average_comments_48h"].toDouble(),
//         redditSubscribers: json["reddit_subscribers"] == null ? null : json["reddit_subscribers"],
//         redditAccountsActive48H: json["reddit_accounts_active_48h"] == null ? null : json["reddit_accounts_active_48h"],
//         telegramChannelUserCount: json["telegram_channel_user_count"],
//     );

//     Map<String, dynamic> toJson() => {
//         "facebook_likes": facebookLikes,
//         "twitter_followers": twitterFollowers == null ? null : twitterFollowers,
//         "reddit_average_posts_48h": redditAveragePosts48H == null ? null : redditAveragePosts48H,
//         "reddit_average_comments_48h": redditAverageComments48H == null ? null : redditAverageComments48H,
//         "reddit_subscribers": redditSubscribers == null ? null : redditSubscribers,
//         "reddit_accounts_active_48h": redditAccountsActive48H == null ? null : redditAccountsActive48H,
//         "telegram_channel_user_count": telegramChannelUserCount,
//     };
// }

// class Description {
//   Description({
//     this.en,
//   });

//   String? en;

//     factory Description.fromJson(Map<String, dynamic> json) => Description(
//         en: json["en"] == null ? null : json["en"],
//     );

//     Map<String, dynamic> toJson() => {
//         "en": en == null ? null : en,
//     };
// }

// class DeveloperData {
//   DeveloperData({
//     this.forks,
//     this.stars,
//     this.subscribers,
//     this.totalIssues,
//     this.closedIssues,
//     this.pullRequestsMerged,
//     this.pullRequestContributors,
//     this.codeAdditionsDeletions4Weeks,
//     this.commitCount4Weeks,
//     this.last4WeeksCommitActivitySeries,
//   });

//   int? forks;
//   int? stars;
//   int? subscribers;
//   int? totalIssues;
//   int? closedIssues;
//   int? pullRequestsMerged;
//   int? pullRequestContributors;
//   CodeAdditionsDeletions4Weeks? codeAdditionsDeletions4Weeks;
//   int? commitCount4Weeks;
//   List<int>? last4WeeksCommitActivitySeries;

//     factory DeveloperData.fromJson(Map<String, dynamic> json) => DeveloperData(
//         forks: json["forks"] == null ? null : json["forks"],
//         stars: json["stars"] == null ? null : json["stars"],
//         subscribers: json["subscribers"] == null ? null : json["subscribers"],
//         totalIssues: json["total_issues"] == null ? null : json["total_issues"],
//         closedIssues: json["closed_issues"] == null ? null : json["closed_issues"],
//         pullRequestsMerged: json["pull_requests_merged"] == null ? null : json["pull_requests_merged"],
//         pullRequestContributors: json["pull_request_contributors"] == null ? null : json["pull_request_contributors"],
//         codeAdditionsDeletions4Weeks: json["code_additions_deletions_4_weeks"] == null ? null : CodeAdditionsDeletions4Weeks.fromJson(json["code_additions_deletions_4_weeks"]),
//         commitCount4Weeks: json["commit_count_4_weeks"] == null ? null : json["commit_count_4_weeks"],
//         last4WeeksCommitActivitySeries: json["last_4_weeks_commit_activity_series"] == null ? null : List<int>.from(json["last_4_weeks_commit_activity_series"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "forks": forks == null ? null : forks,
//         "stars": stars == null ? null : stars,
//         "subscribers": subscribers == null ? null : subscribers,
//         "total_issues": totalIssues == null ? null : totalIssues,
//         "closed_issues": closedIssues == null ? null : closedIssues,
//         "pull_requests_merged": pullRequestsMerged == null ? null : pullRequestsMerged,
//         "pull_request_contributors": pullRequestContributors == null ? null : pullRequestContributors,
//         "code_additions_deletions_4_weeks": codeAdditionsDeletions4Weeks == null ? null : codeAdditionsDeletions4Weeks.toJson(),
//         "commit_count_4_weeks": commitCount4Weeks == null ? null : commitCount4Weeks,
//         "last_4_weeks_commit_activity_series": last4WeeksCommitActivitySeries == null ? null : List<dynamic>.from(last4WeeksCommitActivitySeries.map((x) => x)),
//     };
// }

// class CodeAdditionsDeletions4Weeks {
//   CodeAdditionsDeletions4Weeks({
//     this.additions,
//     this.deletions,
//   });

//   int? additions;
//   int? deletions;

//     factory CodeAdditionsDeletions4Weeks.fromJson(Map<String, dynamic> json) => CodeAdditionsDeletions4Weeks(
//         additions: json["additions"] == null ? null : json["additions"],
//         deletions: json["deletions"] == null ? null : json["deletions"],
//     );

//     Map<String, dynamic> toJson() => {
//         "additions": additions == null ? null : additions,
//         "deletions": deletions == null ? null : deletions,
//     };
// }

// enum Id { BITCOIN, TETHER, BINANCE_USD, TRUE_USD, USD_COIN }

// final idValues = EnumValues({
//     "binance-usd": Id.BINANCE_USD,
//     "bitcoin": Id.BITCOIN,
//     "tether": Id.TETHER,
//     "true-usd": Id.TRUE_USD,
//     "usd-coin": Id.USD_COIN
// });

class Image {
  Image({
    this.thumb,
    this.small,
    this.large,
  });

  String? thumb;
  String? small;
  String? large;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        thumb: json["thumb"] == null ? null : json["thumb"],
        small: json["small"] == null ? null : json["small"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb == null ? null : thumb,
        "small": small == null ? null : small,
        "large": large == null ? null : large,
      };
}

// class Links {
//     Links({
//         this.homepage,
//         this.blockchainSite,
//         this.officialForumUrl,
//         this.chatUrl,
//         this.announcementUrl,
//         this.twitterScreenName,
//         this.facebookUsername,
//         this.bitcointalkThreadIdentifier,
//         this.telegramChannelIdentifier,
//         this.subredditUrl,
//         this.reposUrl,
//     });

//   List<String>? homepage;
//   List<String>? blockchainSite;
//   List<String>? officialForumUrl;
//   List<String>? chatUrl;
//   List<String>? announcementUrl;
//   Id? twitterScreenName;
//   String? facebookUsername;
//   dynamic? bitcointalkThreadIdentifier;
//   String? telegramChannelIdentifier;
//   String? subredditUrl;
//   ReposUrl? reposUrl;

//     factory Links.fromJson(Map<String, dynamic> json) => Links(
//         homepage: json["homepage"] == null ? null : List<String>.from(json["homepage"].map((x) => x)),
//         blockchainSite: json["blockchain_site"] == null ? null : List<String>.from(json["blockchain_site"].map((x) => x)),
//         officialForumUrl: json["official_forum_url"] == null ? null : List<String>.from(json["official_forum_url"].map((x) => x)),
//         chatUrl: json["chat_url"] == null ? null : List<String>.from(json["chat_url"].map((x) => x)),
//         announcementUrl: json["announcement_url"] == null ? null : List<String>.from(json["announcement_url"].map((x) => x)),
//         twitterScreenName: json["twitter_screen_name"] == null ? null : idValues.map[json["twitter_screen_name"]],
//         facebookUsername: json["facebook_username"] == null ? null : json["facebook_username"],
//         bitcointalkThreadIdentifier: json["bitcointalk_thread_identifier"],
//         telegramChannelIdentifier: json["telegram_channel_identifier"] == null ? null : json["telegram_channel_identifier"],
//         subredditUrl: json["subreddit_url"] == null ? null : json["subreddit_url"],
//         reposUrl: json["repos_url"] == null ? null : ReposUrl.fromJson(json["repos_url"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "homepage": homepage == null ? null : List<dynamic>.from(homepage.map((x) => x)),
//         "blockchain_site": blockchainSite == null ? null : List<dynamic>.from(blockchainSite.map((x) => x)),
//         "official_forum_url": officialForumUrl == null ? null : List<dynamic>.from(officialForumUrl.map((x) => x)),
//         "chat_url": chatUrl == null ? null : List<dynamic>.from(chatUrl.map((x) => x)),
//         "announcement_url": announcementUrl == null ? null : List<dynamic>.from(announcementUrl.map((x) => x)),
//         "twitter_screen_name": twitterScreenName == null ? null : idValues.reverse[twitterScreenName],
//         "facebook_username": facebookUsername == null ? null : facebookUsername,
//         "bitcointalk_thread_identifier": bitcointalkThreadIdentifier,
//         "telegram_channel_identifier": telegramChannelIdentifier == null ? null : telegramChannelIdentifier,
//         "subreddit_url": subredditUrl == null ? null : subredditUrl,
//         "repos_url": reposUrl == null ? null : reposUrl.toJson(),
//     };
// }

// class ReposUrl {
//     ReposUrl({
//         this.github,
//         this.bitbucket,
//     });
//   List<String>? github;
//   List<dynamic>? bitbucket;

//     factory ReposUrl.fromJson(Map<String, dynamic> json) => ReposUrl(
//         github: json["github"] == null ? null : List<String>.from(json["github"].map((x) => x)),
//         bitbucket: json["bitbucket"] == null ? null : List<dynamic>.from(json["bitbucket"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "github": github == null ? null : List<dynamic>.from(github.map((x) => x)),
//         "bitbucket": bitbucket == null ? null : List<dynamic>.from(bitbucket.map((x) => x)),
//     };
// }

class MarketData {
  MarketData({
    this.currentPrice,
//     this.totalValueLocked,
//     this.mcapToTvlRatio,
//     this.fdvToTvlRatio,
//     this.roi,
    this.ath,
//     this.athChangePercentage,
//     this.athDate,
    this.atl,
//     this.atlChangePercentage,
//     this.atlDate,
    this.marketCap,
    // this.marketCapRank,
//     this.fullyDilutedValuation,
    this.totalVolume,
    this.high24H,
    this.low24H,
//     this.priceChange24H,
    this.priceChangePercentage24H,
//     this.priceChangePercentage7D,
//     this.priceChangePercentage14D,
//     this.priceChangePercentage30D,
//     this.priceChangePercentage60D,
//     this.priceChangePercentage200D,
//     this.priceChangePercentage1Y,
//     this.marketCapChange24H,
    this.marketCapChangePercentage24H,
//     this.priceChange24HInCurrency,
    this.priceChangePercentage1HInCurrency,
    this.priceChangePercentage24HInCurrency,
    this.priceChangePercentage7DInCurrency,
    this.priceChangePercentage14DInCurrency,
    this.priceChangePercentage30DInCurrency,
    this.priceChangePercentage60DInCurrency,
    this.priceChangePercentage200DInCurrency,
    this.priceChangePercentage1YInCurrency,
//     this.marketCapChange24HInCurrency,
//     this.marketCapChangePercentage24HInCurrency,
//     this.totalSupply,
    this.maxSupply,
    this.circulatingSupply,
    this.sparkline7D,
//     this.lastUpdated,
  });

  Map<String, double>? currentPrice;
//   dynamic? totalValueLocked;
//   dynamic? mcapToTvlRatio;
//   dynamic? fdvToTvlRatio;
//   dynamic? roi;
  Map<String, double>? ath;
//   Map<String, double>? athChangePercentage;
//   Map<String, DateTime>? athDate;
  Map<String, double>? atl;
//   Map<String, double>? atlChangePercentage;
//   Map<String, DateTime>? atlDate;
  Map<String, double>? marketCap;
//   int? marketCapRank;
//   Map<String, double>? fullyDilutedValuation;
  Map<String, double>? totalVolume;
  Map<String, double>? high24H;
  Map<String, double>? low24H;
//   double? priceChange24H;
  double? priceChangePercentage24H;
//   double? priceChangePercentage7D;
//   double? priceChangePercentage14D;
//   double? priceChangePercentage30D;
//   double? priceChangePercentage60D;
//   double? priceChangePercentage200D;
//   double? priceChangePercentage1Y;
//   double? marketCapChange24H;
  double? marketCapChangePercentage24H;
//   Map<String, double>? priceChange24HInCurrency;
  Map<String, double>? priceChangePercentage1HInCurrency;
  Map<String, double>? priceChangePercentage24HInCurrency;
  Map<String, double>? priceChangePercentage7DInCurrency;
  Map<String, double>? priceChangePercentage14DInCurrency;
  Map<String, double>? priceChangePercentage30DInCurrency;
  Map<String, double>? priceChangePercentage60DInCurrency;
  Map<String, double>? priceChangePercentage200DInCurrency;
  Map<String, double>? priceChangePercentage1YInCurrency;
//   Map<String, double>? marketCapChange24HInCurrency;
//   Map<String, double>? marketCapChangePercentage24HInCurrency;
//   int? totalSupply;
  double? maxSupply;
  double? circulatingSupply;
  Sparkline7D? sparkline7D;
//   DateTime? lastUpdated;

  factory MarketData.fromJson(Map<String, dynamic> json) => MarketData(
        currentPrice: json["current_price"] == null
            ? null
            : Map.from(json["current_price"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // totalValueLocked: json["total_value_locked"],
        // mcapToTvlRatio: json["mcap_to_tvl_ratio"],
        // fdvToTvlRatio: json["fdv_to_tvl_ratio"],
        // roi: json["roi"],
        ath: json["ath"] == null
            ? null
            : Map.from(json["ath"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // athChangePercentage: json["ath_change_percentage"] == null ? null : Map.from(json["ath_change_percentage"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // athDate: json["ath_date"] == null ? null : Map.from(json["ath_date"]).map((k, v) => MapEntry<String, DateTime>(k, DateTime.parse(v))),
        atl: json["atl"] == null
            ? null
            : Map.from(json["atl"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // atlChangePercentage: json["atl_change_percentage"] == null ? null : Map.from(json["atl_change_percentage"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // atlDate: json["atl_date"] == null ? null : Map.from(json["atl_date"]).map((k, v) => MapEntry<String, DateTime>(k, DateTime.parse(v))),
        marketCap: json["market_cap"] == null
            ? null
            : Map.from(json["market_cap"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // marketCapRank: json["market_cap_rank"] == null ? null : json["market_cap_rank"],
        // fullyDilutedValuation: json["fully_diluted_valuation"] == null ? null : Map.from(json["fully_diluted_valuation"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        totalVolume: json["total_volume"] == null
            ? null
            : Map.from(json["total_volume"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        high24H: json["high_24h"] == null
            ? null
            : Map.from(json["high_24h"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        low24H: json["low_24h"] == null
            ? null
            : Map.from(json["low_24h"])
                .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // priceChange24H: json["price_change_24h"] == null ? null : json["price_change_24h"].toDouble(),
        priceChangePercentage24H: json["price_change_percentage_24h"] == null
            ? null
            : json["price_change_percentage_24h"]!.toDouble(),
        // priceChangePercentage7D: json["price_change_percentage_7d"] == null ? null : json["price_change_percentage_7d"].toDouble(),
        // priceChangePercentage14D: json["price_change_percentage_14d"] == null ? null : json["price_change_percentage_14d"].toDouble(),
        // priceChangePercentage30D: json["price_change_percentage_30d"] == null ? null : json["price_change_percentage_30d"].toDouble(),
        // priceChangePercentage60D: json["price_change_percentage_60d"] == null ? null : json["price_change_percentage_60d"].toDouble(),
        // priceChangePercentage200D: json["price_change_percentage_200d"] == null ? null : json["price_change_percentage_200d"].toDouble(),
        // priceChangePercentage1Y: json["price_change_percentage_1y"] == null ? null : json["price_change_percentage_1y"].toDouble(),
        // marketCapChange24H: json["market_cap_change_24h"] == null ? null : json["market_cap_change_24h"].toDouble(),
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"] == null
                ? null
                : json["market_cap_change_percentage_24h"]!.toDouble(),
        // priceChange24HInCurrency: json["price_change_24h_in_currency"] == null ? null : Map.from(json["price_change_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage1HInCurrency:
            json["price_change_percentage_1h_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_1h_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage24HInCurrency:
            json["price_change_percentage_24h_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_24h_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage7DInCurrency:
            json["price_change_percentage_7d_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_7d_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage14DInCurrency:
            json["price_change_percentage_14d_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_14d_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage30DInCurrency:
            json["price_change_percentage_30d_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_30d_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage60DInCurrency:
            json["price_change_percentage_60d_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_60d_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage200DInCurrency:
            json["price_change_percentage_200d_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_200d_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        priceChangePercentage1YInCurrency:
            json["price_change_percentage_1y_in_currency"] == null
                ? null
                : Map.from(json["price_change_percentage_1y_in_currency"])
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // marketCapChange24HInCurrency: json["market_cap_change_24h_in_currency"] == null ? null : Map.from(json["market_cap_change_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // marketCapChangePercentage24HInCurrency: json["market_cap_change_percentage_24h_in_currency"] == null ? null : Map.from(json["market_cap_change_percentage_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        // totalSupply: json["total_supply"] == null ? null : json["total_supply"],
        maxSupply: json["max_supply"] == null ? null : json["max_supply"]!,
        circulatingSupply: json["circulating_supply"] == null
            ? null
            : json["circulating_supply"]!,
        sparkline7D: json["sparkline_7d"] == null
            ? null
            : Sparkline7D.fromJson(json["sparkline_7d"]),
        // lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "current_price": currentPrice == null
            ? null
            : Map.from(currentPrice!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "total_value_locked": totalValueLocked,
        // "mcap_to_tvl_ratio": mcapToTvlRatio,
        // "fdv_to_tvl_ratio": fdvToTvlRatio,
        // "roi": roi,
        "ath": ath == null
            ? null
            : Map.from(ath!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "ath_change_percentage": athChangePercentage == null ? null : Map.from(athChangePercentage).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "ath_date": athDate == null ? null : Map.from(athDate).map((k, v) => MapEntry<String, dynamic>(k, v.toIso8601String())),
        "atl": atl == null
            ? null
            : Map.from(atl!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "atl_change_percentage": atlChangePercentage == null ? null : Map.from(atlChangePercentage).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "atl_date": atlDate == null ? null : Map.from(atlDate).map((k, v) => MapEntry<String, dynamic>(k, v.toIso8601String())),
        "market_cap": marketCap == null
            ? null
            : Map.from(marketCap!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "market_cap_rank": marketCapRank == null ? null : marketCapRank,
        // "fully_diluted_valuation": fullyDilutedValuation == null ? null : Map.from(fullyDilutedValuation).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "total_volume": totalVolume == null
            ? null
            : Map.from(totalVolume!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "high_24h": high24H == null
            ? null
            : Map.from(high24H!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "low_24h": low24H == null
            ? null
            : Map.from(low24H!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "price_change_24h": priceChange24H == null ? null : priceChange24H,
        "price_change_percentage_24h":
            priceChangePercentage24H == null ? null : priceChangePercentage24H!,
        // "price_change_percentage_7d": priceChangePercentage7D == null ? null : priceChangePercentage7D,
        // "price_change_percentage_14d": priceChangePercentage14D == null ? null : priceChangePercentage14D,
        // "price_change_percentage_30d": priceChangePercentage30D == null ? null : priceChangePercentage30D,
        // "price_change_percentage_60d": priceChangePercentage60D == null ? null : priceChangePercentage60D,
        // "price_change_percentage_200d": priceChangePercentage200D == null ? null : priceChangePercentage200D,
        // "price_change_percentage_1y": priceChangePercentage1Y == null ? null : priceChangePercentage1Y,
        // "market_cap_change_24h": marketCapChange24H == null ? null : marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H == null
            ? null
            : marketCapChangePercentage24H!,
        // "price_change_24h_in_currency": priceChange24HInCurrency == null ? null : Map.from(priceChange24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_1h_in_currency":
            priceChangePercentage1HInCurrency == null
                ? null
                : Map.from(priceChangePercentage1HInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_24h_in_currency":
            priceChangePercentage24HInCurrency == null
                ? null
                : Map.from(priceChangePercentage24HInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_7d_in_currency":
            priceChangePercentage7DInCurrency == null
                ? null
                : Map.from(priceChangePercentage7DInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_14d_in_currency":
            priceChangePercentage14DInCurrency == null
                ? null
                : Map.from(priceChangePercentage14DInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_30d_in_currency":
            priceChangePercentage30DInCurrency == null
                ? null
                : Map.from(priceChangePercentage30DInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_60d_in_currency":
            priceChangePercentage60DInCurrency == null
                ? null
                : Map.from(priceChangePercentage60DInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_200d_in_currency":
            priceChangePercentage200DInCurrency == null
                ? null
                : Map.from(priceChangePercentage200DInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "price_change_percentage_1y_in_currency":
            priceChangePercentage1YInCurrency == null
                ? null
                : Map.from(priceChangePercentage1YInCurrency!)
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "market_cap_change_24h_in_currency": marketCapChange24HInCurrency == null ? null : Map.from(marketCapChange24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "market_cap_change_percentage_24h_in_currency": marketCapChangePercentage24HInCurrency == null ? null : Map.from(marketCapChangePercentage24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
        // "total_supply": totalSupply == null ? null : totalSupply,
        "max_supply": maxSupply == null ? null : maxSupply,
        "circulating_supply":
            circulatingSupply == null ? null : circulatingSupply,
        "sparkline_7d": sparkline7D == null ? null : sparkline7D!.toJson(),
        // "last_updated": lastUpdated == null ? null : lastUpdated.toIso8601String(),
      };
}

class Sparkline7D {
  Sparkline7D({
    this.price,
  });

  List<double>? price;

  factory Sparkline7D.fromJson(Map<String, dynamic> json) => Sparkline7D(
        price: json["price"] == null
            ? null
            : List<double>.from(json["price"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "price":
            price == null ? null : List<dynamic>.from(price!.map((x) => x)),
      };
}

// class Platforms {
//     Platforms({
//         this.empty,
//     });

//     String? empty;

//     factory Platforms.fromJson(Map<String, dynamic> json) => Platforms(
//         empty: json[""] == null ? null : json[""],
//     );

//     Map<String, dynamic> toJson() => {
//         "": empty == null ? null : empty,
//     };
// }

// class PublicInterestStats {
//     PublicInterestStats({
//         this.alexaRank,
//         this.bingMatches,
//     });

//     int? alexaRank;
//     dynamic? bingMatches;

//     factory PublicInterestStats.fromJson(Map<String, dynamic> json) => PublicInterestStats(
//         alexaRank: json["alexa_rank"] == null ? null : json["alexa_rank"],
//         bingMatches: json["bing_matches"],
//     );

//     Map<String, dynamic> toJson() => {
//         "alexa_rank": alexaRank == null ? null : alexaRank,
//         "bing_matches": bingMatches,
//     };
// }

// class Ticker {
//     Ticker({
//         this.base,
//         this.target,
//         this.market,
//         this.last,
//         this.volume,
//         this.convertedLast,
//         this.convertedVolume,
//         this.trustScore,
//         this.bidAskSpreadPercentage,
//         this.timestamp,
//         this.lastTradedAt,
//         this.lastFetchAt,
//         this.isAnomaly,
//         this.isStale,
//         this.tradeUrl,
//         this.tokenInfoUrl,
//         this.coinId,
//         this.targetCoinId,
//     });

  // Base? base;
  // String? target;
  // Market? market;
  // double? last;
  // double? volume;
  // Map<String, double>? convertedLast;
  // Map<String, double>? convertedVolume;
  // TrustScore? trustScore;
  // double? bidAskSpreadPercentage;
  // DateTime? timestamp;
  // DateTime? lastTradedAt;
  // DateTime? lastFetchAt;
  // bool? isAnomaly;
  // bool? isStale;
  // String? tradeUrl;
  // dynamic? tokenInfoUrl;
  // Id? coinId;
  // TargetCoinId? targetCoinId;

//     factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
//         base: json["base"] == null ? null : json["base"],
//         target: json["target"] == null ? null : json["target"],
//         market: json["market"] == null ? null : Market.fromJson(json["market"]),
//         last: json["last"] == null ? null : json["last"].toDouble(),
//         volume: json["volume"] == null ? null : json["volume"].toDouble(),
//         convertedLast: json["converted_last"] == null ? null : Map.from(json["converted_last"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
//         convertedVolume: json["converted_volume"] == null ? null : Map.from(json["converted_volume"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
//         trustScore: json["trust_score"] == null ? null : trustScoreValues.map[json["trust_score"]],
//         bidAskSpreadPercentage: json["bid_ask_spread_percentage"] == null ? null : json["bid_ask_spread_percentage"].toDouble(),
//         timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
//         lastTradedAt: json["last_traded_at"] == null ? null : DateTime.parse(json["last_traded_at"]),
//         lastFetchAt: json["last_fetch_at"] == null ? null : DateTime.parse(json["last_fetch_at"]),
//         isAnomaly: json["is_anomaly"] == null ? null : json["is_anomaly"],
//         isStale: json["is_stale"] == null ? null : json["is_stale"],
//         tradeUrl: json["trade_url"] == null ? null : json["trade_url"],
//         tokenInfoUrl: json["token_info_url"],
//         coinId: json["coin_id"] == null ? null : json["coin_id"],
//         targetCoinId: json["target_coin_id"] == null ? null : idValues.map[json["target_coin_id"]],
//     );

//     Map<String, dynamic> toJson() => {
//         "base": base == null ? null : base,
//         "target": target == null ? null : target,
//         "market": market == null ? null : market.toJson(),
//         "last": last == null ? null : last,
//         "volume": volume == null ? null : volume,
//         "converted_last": convertedLast == null ? null : Map.from(convertedLast).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "converted_volume": convertedVolume == null ? null : Map.from(convertedVolume).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "trust_score": trustScore == null ? null : trustScoreValues.reverse[trustScore],
//         "bid_ask_spread_percentage": bidAskSpreadPercentage == null ? null : bidAskSpreadPercentage,
//         "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
//         "last_traded_at": lastTradedAt == null ? null : lastTradedAt.toIso8601String(),
//         "last_fetch_at": lastFetchAt == null ? null : lastFetchAt.toIso8601String(),
//         "is_anomaly": isAnomaly == null ? null : isAnomaly,
//         "is_stale": isStale == null ? null : isStale,
//         "trade_url": tradeUrl == null ? null : tradeUrl,
//         "token_info_url": tokenInfoUrl,
//         "coin_id": coinId == null ? null : coinId,
//         "target_coin_id": targetCoinId == null ? null : idValues.reverse[targetCoinId],
//     };
// }

// class Market {
//     Market({
//         this.name,
//         this.identifier,
//         this.hasTradingIncentive,
//     });

//     String? name;
//     String? identifier;
//     bool? hasTradingIncentive;

//     factory Market.fromJson(Map<String, dynamic> json) => Market(
//         name: json["name"] == null ? null : json["name"],
//         identifier: json["identifier"] == null ? null : json["identifier"],
//         hasTradingIncentive: json["has_trading_incentive"] == null ? null : json["has_trading_incentive"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name == null ? null : name,
//         "identifier": identifier == null ? null : identifier,
//         "has_trading_incentive": hasTradingIncentive == null ? null : hasTradingIncentive,
//     };
// }

// enum TrustScore { GREEN }

// final trustScoreValues = EnumValues({
//     "green": TrustScore.GREEN
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
