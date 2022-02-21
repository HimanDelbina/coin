import 'dart:convert';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/model/olhc_model.dart';
import 'package:coin/model/select_coin_model.dart';
import 'package:coin/page/Coin/Chart/olhc_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CoinSelect extends StatefulWidget {
  String? id;
  double? price;
  double? changePrice;
  CoinSelect(
      {Key? key,
      @required this.id,
      @required this.price,
      @required this.changePrice})
      : super(key: key);

  @override
  _CoinSelectState createState() => _CoinSelectState();
}

class _CoinSelectState extends State<CoinSelect> {
  @override
  void initState() {
    super.initState();
    getSeledtCoin();
    getOLHC();
  }

  List<Color> redColor = [
    Colors.red.withOpacity(0.4),
    Colors.red.withOpacity(0),
  ];
  List<Color> greenColor = [
    Colors.green.withOpacity(0.4),
    Colors.green.withOpacity(0),
  ];

  bool chartShoe = false;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: himan != null
            ? Column(
                children: [
                  Container(
                    height: myHeight * 0.1,
                    width: myWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: myHeight * 0.03,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: himan!.marketCapRank != null
                                    ? Text(
                                        "#" + himan!.marketCapRank.toString(),
                                        style: const TextStyle(fontSize: 12.0),
                                      )
                                    : Text("specified".tr()),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          himan!.symbol != null
                              ? Text(
                                  himan!.symbol.toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )
                              : Text("specified".tr()),
                          const SizedBox(width: 5.0),
                          Center(
                            child: Container(
                              height: myHeight * 0.04,
                              width: myWidth * 0.08,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          himan!.image!.small.toString()))),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          height: myWidth * 0.2,
                          width: myWidth,
                          // color: Colors.amber,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Tooltip(
                                  message: "percentage24".tr(),
                                  preferBelow: false,
                                  triggerMode: TooltipTriggerMode.longPress,
                                  waitDuration: const Duration(seconds: 3),
                                  child: Container(
                                    height: myHeight * 0.045,
                                    width: myWidth * 0.2,
                                    decoration: BoxDecoration(
                                        color: widget.changePrice! <= 0
                                            ? Colors.red
                                            : Colors.green,
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '% ' +
                                              widget.changePrice!
                                                  .toStringAsFixed(2)
                                                  .toPersianDigit(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          widget.changePrice! <= 0
                                              ? Icons.arrow_drop_down_rounded
                                              : Icons.arrow_drop_up_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(himan!.name.toString()),
                                    Text(
                                      r'$ ' +
                                          widget.price
                                              .toString()
                                              .seRagham()
                                              .toPersianDigit(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Container(
                            height: myHeight * 0.06,
                            width: myWidth,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius:
                                    BorderRadiusDirectional.circular(5)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        chartShoe = !chartShoe;
                                      });
                                    },
                                    child: chartShoe == false
                                        ? Container(
                                            height: myHeight * 0.035,
                                            width: myWidth * 0.05,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/icon/candle.png"))),
                                          )
                                        : Container(
                                            height: myHeight * 0.035,
                                            width: myWidth * 0.05,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/icon/line.png"))),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: myHeight * 0.3,
                            width: myWidth,
                            decoration: BoxDecoration(
                                // color: Colors.grey.withOpacity(0.1),
                                borderRadius:
                                    BorderRadiusDirectional.circular(5)),
                            child: chartShoe == false
                                ? Sparkline(
                                    data: chartData,
                                    lineWidth: 1.5,
                                    lineColor: Colors.green,
                                    // sharpCorners: true,
                                    // enableGridLines: true,
                                    // gridLineAmount: 8,
                                    // gridLineColor: Colors.grey.withOpacity(0.4),
                                    // gridLineLabelPrecision: 1,
                                    // gridLineLabelColor: Colors.grey,
                                    // averageLabel: true,
                                    averageLine: true,
                                    useCubicSmoothing: true,
                                    cubicSmoothingFactor: 0.2,
                                    enableThreshold: true,
                                  )
                                : const OLHCPage(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Container(
                            width: myWidth,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "statistics".tr(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "least".tr(),
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 13.0),
                                    ),
                                    Container(
                                      // height: myHeight * 0.05,
                                      width: myWidth * 0.35,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                child: Tooltip(
                                                  message: "average24".tr(),
                                                  preferBelow: false,
                                                  waitDuration: const Duration(
                                                      seconds: 2),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Text(
                                                      "24H",
                                                      style: TextStyle(
                                                          fontSize: 11.0),
                                                    ),
                                                  ),
                                                )),
                                            Tooltip(
                                              message: "average1Day".tr(),
                                              preferBelow: false,
                                              waitDuration:
                                                  const Duration(seconds: 2),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Text(
                                                  "1D",
                                                  style:
                                                      TextStyle(fontSize: 11.0),
                                                ),
                                              ),
                                            ),
                                            Tooltip(
                                              message: "average7Day".tr(),
                                              preferBelow: false,
                                              waitDuration:
                                                  const Duration(seconds: 2),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Text(
                                                  "7D",
                                                  style:
                                                      TextStyle(fontSize: 11.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "most".tr(),
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 13.0),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      child: LinearProgressIndicator(
                                        color: Colors.blueGrey,
                                        backgroundColor: Colors.red,
                                        minHeight: 6,
                                        value: averageValue,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    himan!.marketData!.low24H != null
                                        ? Text(
                                            r'$ ' +
                                                himan!
                                                    .marketData!.low24H!["usd"]
                                                    .toString()
                                                    .seRagham()
                                                    .toPersianDigit(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0))
                                        : Text("specified".tr()),
                                    himan!.marketData!.high24H != null
                                        ? Text(
                                            r'$ ' +
                                                himan!
                                                    .marketData!.high24H!["usd"]
                                                    .toString()
                                                    .seRagham()
                                                    .toPersianDigit(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0))
                                        : Text("specified".tr()),
                                  ],
                                ),
                                const Divider(),
                                amar(),
                                const SizedBox(height: 30.0),
                                // const Divider(),
                                AmarChangePrice(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child:
                    Lottie.asset("assets/animation/loading.json", height: 40.0),
              ),
      ),
    );
  }

  var selectCoin = [];
  var selectCoinList;
  var chartData;
  SelectCoinModel? himan;
  double? valueHigh24;
  double? valueLow24;
  double? averageValue;

  Future<SelectCoinModel?> getSeledtCoin() async {
    String infourl = 'https://api.coingecko.com/api/v3/coins/' +
        widget.id.toString() +
        '?localization=false&sparkline=true';
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      var x = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        himan = SelectCoinModel.fromJson(x);
        print(himan);
        chartData = himan!.marketData!.sparkline7D!.price;
        valueHigh24 = himan!.marketData!.high24H!["usd"];
        valueLow24 = himan!.marketData!.low24H!["usd"];
        averageValue = (valueHigh24! + valueLow24!) / 2;

        print(averageValue);
      });
      return himan;
    }
  }

  var olhcChart;
  var olhcChartList;

  Future<SelectCoinModel?> getOLHC() async {
    String infourl =
        'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=1';
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      var x = json.decode(response.body);
      var modelList = x.map((e) => OlhcModel.fromJson(e)).toList();
      return modelList;
    }
  }

  Widget dateAmarShow(String selct, String selected) {
    return GestureDetector(
      // onTap: addToValue,
      onTap: () {
        setState(() {
          showSelectedPrice = selct;
          showSelectedPriceText = selected;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                showSelectedPrice == selct ? Colors.white : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              selct,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: showSelectedPrice == selct
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          )),
    );
  }

  Widget dateAmar(var ifData, String title, double ifColor) {
    return Row(
      children: [
        ifData != null
            ? Text(
                "% " + title,
                style: TextStyle(
                    color: ifColor != null
                        ? ifColor <= 0
                            ? Colors.red
                            : Colors.green
                        : Colors.grey),
              )
            : Text("rank".tr()),
        Icon(
            ifColor != null
                ? ifColor <= 0
                    ? Icons.arrow_drop_down_rounded
                    : Icons.arrow_drop_up_rounded
                : Icons.minimize,
            color: ifColor != null
                ? ifColor <= 0
                    ? Colors.red
                    : Colors.green
                : Colors.grey),
      ],
    );
  }

  String? showSelectedPrice = "24H";
  String? showSelectedPriceText = "24 ساعت گذشته";
  Widget AmarChangePrice() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "priceChanges".tr(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            )
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Text(
                "changeLanguageDescription".tr(),
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12.0),
              )
            ],
          ),
        ),
        Container(
          height: myHeight * 0.05,
          width: myWidth,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dateAmarShow("1H", "last1Hour".tr().toPersianDigit()),
                dateAmarShow("24H", "last24Hour".tr().toPersianDigit()),
                dateAmarShow("7D", "last7Day".tr().toPersianDigit()),
                dateAmarShow("14D", "last14Day".tr().toPersianDigit()),
                dateAmarShow("30D", "3last30Day".tr().toPersianDigit()),
                dateAmarShow("60D", "last60Day".tr().toPersianDigit()),
                dateAmarShow("200D", "last200Day".tr().toPersianDigit()),
                dateAmarShow("1Y", "last1Year".tr().toPersianDigit()),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "percentagePrice".tr() + "${showSelectedPriceText}" + " : ",
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
              showSelectedPrice == "1H"
                  ? dateAmar(
                      himan!.marketData!.priceChangePercentage1HInCurrency,
                      himan!
                          .marketData!.priceChangePercentage1HInCurrency!["usd"]
                          .toString()
                          .toPersianDigit(),
                      himan!.marketData!
                          .priceChangePercentage1HInCurrency!["usd"]!
                          .toDouble(),
                    )
                  : showSelectedPrice == "24H"
                      ? dateAmar(
                          himan!.marketData!.priceChangePercentage24HInCurrency,
                          himan!.marketData!
                              .priceChangePercentage24HInCurrency!["usd"]
                              .toString()
                              .toPersianDigit(),
                          himan!.marketData!
                              .priceChangePercentage24HInCurrency!["usd"]!
                              .toDouble(),
                        )
                      : showSelectedPrice == "7D"
                          ? dateAmar(
                              himan!.marketData!
                                  .priceChangePercentage7DInCurrency,
                              himan!.marketData!
                                  .priceChangePercentage7DInCurrency!["usd"]
                                  .toString()
                                  .toPersianDigit(),
                              himan!.marketData!
                                  .priceChangePercentage7DInCurrency!["usd"]!
                                  .toDouble(),
                            )
                          : showSelectedPrice == "14D"
                              ? dateAmar(
                                  himan!.marketData!
                                      .priceChangePercentage14DInCurrency,
                                  himan!
                                      .marketData!
                                      .priceChangePercentage14DInCurrency![
                                          "usd"]
                                      .toString()
                                      .toPersianDigit(),
                                  himan!
                                      .marketData!
                                      .priceChangePercentage14DInCurrency![
                                          "usd"]!
                                      .toDouble(),
                                )
                              : showSelectedPrice == "30D"
                                  ? dateAmar(
                                      himan!.marketData!
                                          .priceChangePercentage30DInCurrency,
                                      himan!
                                          .marketData!
                                          .priceChangePercentage30DInCurrency![
                                              "usd"]
                                          .toString()
                                          .toPersianDigit(),
                                      himan!
                                          .marketData!
                                          .priceChangePercentage30DInCurrency![
                                              "usd"]!
                                          .toDouble(),
                                    )
                                  : showSelectedPrice == "60D"
                                      ? dateAmar(
                                          himan!.marketData!
                                              .priceChangePercentage60DInCurrency,
                                          himan!
                                              .marketData!
                                              .priceChangePercentage60DInCurrency![
                                                  "usd"]
                                              .toString()
                                              .toPersianDigit(),
                                          himan!
                                              .marketData!
                                              .priceChangePercentage60DInCurrency![
                                                  "usd"]!
                                              .toDouble(),
                                        )
                                      : showSelectedPrice == "200D"
                                          ? dateAmar(
                                              himan!.marketData!
                                                  .priceChangePercentage200DInCurrency,
                                              himan!
                                                  .marketData!
                                                  .priceChangePercentage200DInCurrency![
                                                      "usd"]
                                                  .toString()
                                                  .toPersianDigit(),
                                              himan!
                                                  .marketData!
                                                  .priceChangePercentage200DInCurrency![
                                                      "usd"]!
                                                  .toDouble(),
                                            )
                                          : showSelectedPrice == "1Y"
                                              ? dateAmar(
                                                  himan!.marketData!
                                                      .priceChangePercentage1YInCurrency,
                                                  himan!
                                                      .marketData!
                                                      .priceChangePercentage1YInCurrency![
                                                          "usd"]
                                                      .toString()
                                                      .toPersianDigit(),
                                                  himan!
                                                      .marketData!
                                                      .priceChangePercentage1YInCurrency![
                                                          "usd"]!
                                                      .toDouble(),
                                                )
                                              : const Text(""),
            ],
          ),
        )
      ],
    );
  }

  Widget amarDetails(String title, var data, String showData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 12.0),
        ),
        data != null
            ? Text(
                showData,
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
              )
            : Text("specified".tr()),
      ],
    );
  }

  Widget amar() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: myWidth * 0.46,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                amarDetails(
                    "marketVolume".tr(),
                    himan!.marketData!.marketCap!["usd"],
                    himan!.marketData!.marketCap!["usd"]
                        .toString()
                        .seRagham()
                        .toPersianDigit()),
                const Divider(),
                amarDetails(
                    "tradingVolume24".tr(),
                    himan!.marketData!.totalVolume!["usd"],
                    himan!.marketData!.totalVolume!["usd"]
                        .toString()
                        .seRagham()
                        .toPersianDigit()),
                const Divider(),
                amarDetails(
                    "coinNumber".tr(),
                    himan!.marketData!.maxSupply!,
                    himan!.marketData!.maxSupply!
                        .toString()
                        .seRagham()
                        .toPersianDigit()),
                const Divider(),
                amarDetails(
                    "highestPriceCoin".tr(),
                    himan!.marketData!.ath!['usd'],
                    r"$ " +
                        himan!.marketData!.ath!['usd']
                            .toString()
                            .seRagham()
                            .toPersianDigit()),
                const Divider(),
                amarDetails(
                    "lowestPriceCoin".tr(),
                    himan!.marketData!.atl!['usd'],
                    r"$ " +
                        himan!.marketData!.atl!['usd']
                            .toString()
                            .seRagham()
                            .toPersianDigit()),
              ],
            ),
          ),
        ),
        Container(
          height: myHeight * 0.35,
          width: myWidth * 0.001,
          color: Colors.blueGrey.withOpacity(0.5),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                amarDetails(
                    "circulationCoin".tr(),
                    himan!.marketData!.circulatingSupply,
                    himan!.marketData!.circulatingSupply
                        .toString()
                        .seRagham()
                        .toPersianDigit()),
                const Divider(),
                amarDetails(
                    "marketDominance".tr(),
                    himan!.sentimentVotesDownPercentage,
                    "% " +
                        himan!.sentimentVotesDownPercentage
                            .toString()
                            .toPersianDigit()),
                const Divider(),
                amarDetails("rankCoin".tr(), himan!.marketCapRank,
                    "# " + himan!.marketCapRank.toString().toPersianDigit()),
                const Divider(),
                amarDetails("popularity".tr(), himan!.communityScore,
                    "% " + himan!.communityScore.toString().toPersianDigit()),
                const Divider(),
                amarDetails("dateCreateCoin".tr(), himan!.genesisDate,
                    himan!.genesisDate.toString().toPersianDate()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
