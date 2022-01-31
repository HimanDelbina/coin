import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/model/coin_model.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'coin_select.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  void initState() {
    super.initState();
    getcoinMarketLoop();
  }

  bool _isRefreshing = true;

  getcoinMarketLoop() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      context.read<ChartGet>().fetchData;
    }
  }

  List<Color> redColor = [
    Colors.red.withOpacity(0.3),
    Colors.red.withOpacity(0),
  ];
  List<Color> greenColor = [
    Colors.green.withOpacity(0.3),
    Colors.green.withOpacity(0),
  ];
  List<Color> greyColor = [
    Colors.grey.withOpacity(0.3),
    Colors.grey.withOpacity(0),
  ];

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    context.read<ChartGet>().fetchData;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Container(
                height: myHeight * 0.07,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 15.0),
                    child: Row(
                      children: const [
                        Text(
                          "رمز ارزها",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          "صرافی ها",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ChartGet>(
                  builder: (context, value, child) {
                    return value.map.length == 0 && !value.error
                        ? Center(
                            child: Lottie.asset("assets/animation/loading.json",
                                height: 40.0),
                          )
                        : value.error
                            ? Text(value.errorMessage.toString())
                            : ListView.builder(
                                itemCount: value.map.length,
                                itemBuilder: (context, index) {
                                  var y =
                                      value.map[index].sparklineIn7D!.price!;
                                  var x = y
                                      .getRange(y.length - 30, y.length)
                                      .toList();
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CoinSelect(
                                                      changePrice: value
                                                          .map[index]
                                                          .marketCapChangePercentage24H!,
                                                      price: value.map[index]
                                                          .currentPrice,
                                                      id: value.map[index].id
                                                          .toString()),
                                                ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        value.map[index]
                                                                    .currentPrice !=
                                                                null
                                                            ? Text(
                                                                r'$ ' +
                                                                    value
                                                                        .map[
                                                                            index]
                                                                        .currentPrice
                                                                        .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            : const Text(
                                                                "تعیین نشده")
                                                      ],
                                                    ),
                                                    Container(
                                                      height: myHeight * 0.07,
                                                      width: myWidth * 0.2,
                                                      child: Sparkline(
                                                        data: x,
                                                        lineWidth: 1.5,
                                                        fillGradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          stops: const [
                                                            0.0,
                                                            0.7
                                                          ],
                                                          colors: value
                                                                      .map[
                                                                          index]
                                                                      .marketCapChangePercentage24H !=
                                                                  null
                                                              ? value.map[index]
                                                                          .marketCapChangePercentage24H! <=
                                                                      0
                                                                  ? redColor
                                                                  : greenColor
                                                              : greyColor,
                                                        ),
                                                        fillMode:
                                                            FillMode.below,
                                                        useCubicSmoothing: true,
                                                        cubicSmoothingFactor:
                                                            0.4,
                                                        enableThreshold: true,
                                                        lineColor: value
                                                                    .map[index]
                                                                    .marketCapChangePercentage24H !=
                                                                null
                                                            ? value.map[index]
                                                                        .marketCapChangePercentage24H! <=
                                                                    0
                                                                ? Colors.red
                                                                : Colors.green
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ShowOne(
                                                value.map[index].image != null
                                                    ? value.map[index].image!
                                                    : "",
                                                value.map[index].name != null
                                                    ? value.map[index].name!
                                                    : "",
                                                value.map[index].symbol != null
                                                    ? value.map[index].symbol!
                                                    : "",
                                                value.map[index]
                                                            .marketCapRank !=
                                                        null
                                                    ? value.map[index]
                                                        .marketCapRank!
                                                    : 0,
                                                value.map[index]
                                                            .marketCapChangePercentage24H !=
                                                        null
                                                    ? value.map[index]
                                                        .marketCapChangePercentage24H!
                                                    : 0,
                                                value.map[index]
                                                            .marketCapChangePercentage24H !=
                                                        null
                                                    ? value.map[index]
                                                                .marketCapChangePercentage24H! <=
                                                            0
                                                        ? Icons
                                                            .arrow_drop_down_rounded
                                                        : Icons
                                                            .arrow_drop_up_rounded
                                                    : Icons.minimize_sharp,
                                                value.map[index]
                                                            .marketCapChangePercentage24H !=
                                                        null
                                                    ? value.map[index]
                                                                .marketCapChangePercentage24H! <=
                                                            0
                                                        ? Colors.red
                                                        : Colors.green
                                                    : Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(indent: 10, endIndent: 10),
                                    ],
                                  );
                                },
                              );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ShowOne(String image, String name, String symble, int rank,
      double darsad, IconData icon, Color color) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      width: myWidth * 0.47,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  // const Spacer(),
                  Text(
                    darsad.toStringAsFixed(2) + " %",
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Icon(
                    icon,
                    color: color,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      symble,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        rank.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10.0),
          Container(
            height: myHeight * 0.04,
            width: myWidth * 0.08,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(image))),
          ),
        ],
      ),
    );
  }

  List? coinMarket = [];
  List? chartLast = [];
  var coinMarketList;
  Future<List<CoinMarket>?> getcoinMarket() async {
    List<CoinMarket>? himan = [];
    // const infourl = 'http://128.65.186.187:1989/api/boperation';
    const infourl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true';

    setState(() {
      _isRefreshing = true;
    });
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      _isRefreshing = false;
    });
    if (response.statusCode == 200) {
      // var x = json.decode(response.body);
      var x = response.body;
      // coinMarketList = x.map((e) => CoinMarket.fromJson(e)).toList();
      coinMarketList = coinMarketFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    }
  }
}
