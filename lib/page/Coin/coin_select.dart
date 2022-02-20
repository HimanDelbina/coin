import 'dart:convert';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/model/olhc_model.dart';
import 'package:coin/model/select_coin_model.dart';
import 'package:coin/page/Coin/Chart/olhc_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

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
        child: Container(
            height: myHeight,
            width: myWidth,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: himan!.marketCapRank != null
                                        ? Text(
                                            "#" +
                                                himan!.marketCapRank.toString(),
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          )
                                        : const Text("تعیین نشده"),
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
                                  : const Text("تعیین نشده"),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Tooltip(
                                      message: "درصد رشد ارز در 24 ساعت گذشته",
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
                                                BorderRadiusDirectional
                                                    .circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.changePrice!
                                                      .toStringAsFixed(2) +
                                                  '%',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              widget.changePrice! <= 0
                                                  ? Icons
                                                      .arrow_drop_down_rounded
                                                  : Icons.arrow_drop_up_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(himan!.name.toString()),
                                        Text(
                                          r'$' + widget.price.toString(),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                      children: const [
                                        Text(
                                          "آمار",
                                          style: TextStyle(
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
                                        const Text(
                                          "کمترین",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 13.0),
                                        ),
                                        Container(
                                          // height: myHeight * 0.05,
                                          width: myWidth * 0.35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                    ),
                                                    child: const Tooltip(
                                                      message:
                                                          "میانگین قیمت ارز در 24 ساعت گذشته",
                                                      preferBelow: false,
                                                      waitDuration:
                                                          Duration(seconds: 2),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Text(
                                                          "24H",
                                                          style: TextStyle(
                                                              fontSize: 11.0),
                                                        ),
                                                      ),
                                                    )),
                                                const Tooltip(
                                                  message:
                                                      "میانگین قیمت ارز در 1 روز گذشته",
                                                  preferBelow: false,
                                                  waitDuration:
                                                      Duration(seconds: 2),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Text(
                                                      "1D",
                                                      style: TextStyle(
                                                          fontSize: 11.0),
                                                    ),
                                                  ),
                                                ),
                                                const Tooltip(
                                                  message:
                                                      "میانگین قیمت ارز در 7 روز گذشته",
                                                  preferBelow: false,
                                                  waitDuration:
                                                      Duration(seconds: 2),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Text(
                                                      "7D",
                                                      style: TextStyle(
                                                          fontSize: 11.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "بیشترین",
                                          style: TextStyle(
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
                                                r'$' +
                                                    himan!.marketData!
                                                        .low24H!["usd"]
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0))
                                            : const Text("تعیین نشده"),
                                        himan!.marketData!.high24H != null
                                            ? Text(
                                                r'$' +
                                                    himan!.marketData!
                                                        .high24H!["usd"]
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0))
                                            : const Text("تعیین نشده"),
                                      ],
                                    ),
                                    const Divider(),
                                    Amar(),
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
                    child: Lottie.asset("assets/animation/loading.json",
                        height: 40.0),
                  )),
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
    // setState(() {
    //   _isRefreshing = true;
    // });
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    // setState(() {
    //   _isRefreshing = false;
    // });
    if (response.statusCode == 200) {
      var x = json.decode(utf8.decode(response.bodyBytes));
      // var x = response.body;

      //  var slist= selectCoinModelFromJson(x);
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
      // var x = response.body;

      var modelList = x.map((e) => OlhcModel.fromJson(e)).toList();
      //  var slist= selectCoinModelFromJson(x);
      // setState(() {
      //   olhcChart = x;
      // });
      print("object");
      return modelList;
    }
  }

  Widget DateAmarShow(String selct, String selected) {
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
          children: const [
            Text(
              "تغییرات قیمتی",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            )
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: const [
              Text(
                "با انتخاب زمان مورد نظر خود میتوانید درصد تغییرات قیمتی را ببینید",
                style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
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
                DateAmarShow("1H", "1 ساعت گذشته"),
                DateAmarShow("24H", "24 ساعت گذشته"),
                DateAmarShow("7D", "7 روز گذشته"),
                DateAmarShow("14D", "14 روز گذشته"),
                DateAmarShow("30D", "30 روز گذشته"),
                DateAmarShow("60D", "14 60 روز گذشته"),
                DateAmarShow("200D", "200 روز گذشته"),
                DateAmarShow("1Y", "1 سال گذشته"),
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
                "درصد تغییرات قیمتی در ${showSelectedPriceText}" + " : ",
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
              showSelectedPrice == "1H"
                  ? dateAmar(
                      himan!.marketData!.priceChangePercentage1HInCurrency,
                      himan!
                          .marketData!.priceChangePercentage1HInCurrency!["usd"]
                          .toString(),
                      himan!.marketData!
                          .priceChangePercentage1HInCurrency!["usd"]!
                          .toDouble(),
                    )
                  : showSelectedPrice == "24H"
                      ? dateAmar(
                          himan!.marketData!.priceChangePercentage24HInCurrency,
                          himan!.marketData!
                              .priceChangePercentage24HInCurrency!["usd"]
                              .toString(),
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
                                  .toString(),
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
                                      .toString(),
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
                                          .toString(),
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
                                              .toString(),
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
                                                  .toString(),
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
                                                      .toString(),
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

  Widget Amar() {
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
                const Text(
                  "حجم بازار",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.marketCap!["usd"] != null
                    ? Text(
                        r"$" + himan!.marketData!.marketCap!["usd"].toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "حجم معامله در 24 ساعت گذشته",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.totalVolume!['usd'] != null
                    ? Text(
                        r"$" +
                            himan!.marketData!.totalVolume!['usd'].toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "تعداد ارزهای تولید شده",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.maxSupply == null
                    ? const Text(
                        "تعداد این ارز تعیین نشده",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        r"$" + himan!.marketData!.maxSupply.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                const Divider(),
                const Text(
                  "بالاترین قیمت این ارز تا کنون",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.ath!['usd'] != null
                    ? Text(
                        r"$" + himan!.marketData!.ath!['usd'].toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "پایین ترین قیمت این ارز",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.atl!['usd'] != null
                    ? Text(
                        r"$" + himan!.marketData!.atl!['usd'].toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
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
                const Text(
                  "تعداد ارز در حال گردش",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketData!.circulatingSupply != null
                    ? Text(
                        himan!.marketData!.circulatingSupply!.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "تسلط بر بازار",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.sentimentVotesDownPercentage != null
                    ? Text(
                        "%" + himan!.sentimentVotesDownPercentage!.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "رتبه ارز",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.marketCapRank != null
                    ? Text(
                        "#" + himan!.marketCapRank!.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "محبوبیت در جامعه",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.communityScore != null
                    ? Text(
                        "%" + himan!.communityScore!.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
                const Divider(),
                const Text(
                  "تاریخ تولید ارز",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                ),
                himan!.genesisDate != null
                    ? Text(
                        himan!.genesisDate!.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      )
                    : const Text("تعیین نشده"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
