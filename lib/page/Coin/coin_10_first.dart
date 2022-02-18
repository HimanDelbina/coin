import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/model/coin_model.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:coin/provider/getcoin_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'coin_select.dart';

class Coin10First extends StatefulWidget {
  const Coin10First({Key? key}) : super(key: key);

  @override
  _Coin10FirstState createState() => _Coin10FirstState();
}

class _Coin10FirstState extends State<Coin10First> {
  getcoinMarketLoop() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 10));
      context.read<CoinGet>().fetchData;
    }
  }

  List<Color> redColor = [
    Colors.red.withOpacity(0.4),
    Colors.red.withOpacity(0),
  ];
  List<Color> greenColor = [
    Colors.green.withOpacity(0.4),
    Colors.green.withOpacity(0),
  ];
  List<Color> greyColor = [
    Colors.grey.withOpacity(0.4),
    Colors.grey.withOpacity(0),
  ];

  @override
  void initState() {
    super.initState();
    getcoinMarketLoop();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    context.read<CoinGet>().fetchData;
    context.read<ChartGet>().fetchData;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Container(
      height: myHeight * 0.27,
      width: myWidth,
      // color:Colors.amber,
      child: Consumer<CoinGet>(
        builder: (context, value, child) {
          return value.map.length == 0 && !value.error
              ? Center(
                  child: Lottie.asset("assets/animation/loading.json",
                      height: 40.0),
                )
              : value.error
                  ? Text(value.errorMessage.toString())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: myHeight * 0.22,
                          width: myWidth,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "top10".tr(),
                                      style: TextStyle(
                                        color: theme.textColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "more".tr(),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: theme.moreColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    CoinMarket coinMarket = value.map[index];
                                    var y =
                                        value.map[index].sparklineIn7D!.price;
                                    var x = y!
                                        .getRange(y.length - 30, y.length)
                                        .toList();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Center(
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
                                          child: Container(
                                            height: myHeight * 0.17,
                                            width: myWidth * 0.34,
                                            decoration: BoxDecoration(
                                              color: theme.conColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height:
                                                              myHeight * 0.07,
                                                          // width: myWidth*0.15
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Sparkline(
                                                              // data: coinMarket![index]
                                                              //     .sparklineIn7D
                                                              //     .price,
                                                              data: x != null
                                                                  ? x
                                                                  : [],
                                                              lineWidth: 1.5,
                                                              fillGradient:
                                                                  LinearGradient(
                                                                stops: const [
                                                                  0,
                                                                  0.8
                                                                ],
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: value
                                                                            .map[
                                                                                index]
                                                                            .marketCapChangePercentage24H !=
                                                                        null
                                                                    ? value.map[index].marketCapChangePercentage24H! <=
                                                                            0
                                                                        ? redColor
                                                                        : greenColor
                                                                    : greyColor,
                                                              ),
                                                              fillMode: FillMode
                                                                  .below,
                                                              useCubicSmoothing:
                                                                  true,
                                                              cubicSmoothingFactor:
                                                                  0.2,
                                                              enableThreshold:
                                                                  true,
                                                              lineColor: value
                                                                          .map[
                                                                              index]
                                                                          .marketCapChangePercentage24H !=
                                                                      null
                                                                  ? value.map[index].marketCapChangePercentage24H! <=
                                                                          0
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .green
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 20.0),
                                                      Container(
                                                        height: myHeight * 0.04,
                                                        width: myWidth * 0.08,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2)),
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: NetworkImage(value
                                                                    .map[index]
                                                                    .image
                                                                    .toString()))),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Spacer(),
                                                          value.map[index]
                                                                      .name !=
                                                                  null
                                                              ? Text(
                                                                  value
                                                                      .map[
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: theme
                                                                          .textColor,
                                                                      fontSize:
                                                                          13.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text(
                                                                  "تعیین نشده",
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .textColor,
                                                                  )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Spacer(),
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
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: theme
                                                                        .textColor,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "تعیین نشده",
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .textColor,
                                                                  )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Spacer(),
                                                      value.map[index]
                                                                  .marketCapChangePercentage24H !=
                                                              null
                                                          ? Text(
                                                              value.map[index]
                                                                  .marketCapChangePercentage24H
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: value
                                                                            .map[
                                                                                index]
                                                                            .marketCapChangePercentage24H! <=
                                                                        0
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green,
                                                              ),
                                                            )
                                                          : Text("تعیین نشده",
                                                              style: TextStyle(
                                                                color: theme
                                                                    .textColor,
                                                              )),
                                                      Icon(
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
                                                            : Icons.minimize,
                                                        color: value.map[index]
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
