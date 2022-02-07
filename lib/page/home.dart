import 'dart:async';
import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/Notification/product.dart';
import 'package:coin/Notification/product_details.dart';
import 'package:coin/model/coin_model.dart';

import 'package:coin/page/Coin/coin_select.dart';

import 'package:coin/page/Coin/trends.dart';
import 'package:coin/page/Whale/whale.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:coin/provider/getcoin_provider.dart';
import 'package:coin/static/filter_static.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Coin/Chart/olhc_page.dart';
import 'News/news.dart';
import 'filter_page.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  // final String? message;
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController? _controller;
  ScrollController? scrollController;

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((tokenValue) async {
      final SharedPreferences fcm_toen_shared =
          await SharedPreferences.getInstance();
      fcm_toen_shared.setString('token', tokenValue.toString());
      print("FCM_Token_get:  $fcm_toen_shared");
      print("FCM_Token:  ");
      print(tokenValue);
    });

    FilterStaticFile.widgetBool = [false, false, false, false];

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin!
        .initialize(initSettings, onSelectNotification: onSelectNotification);

    setupInteractedMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                channelShowBadge: true,
                autoCancel: true,
                // icon: '@drawable/ic_notifications_icon',
              ),
            ),
            payload: action);
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
    getcoinMarketLoop();
    // getTrend();
    scrollController = ScrollController();
    animate();
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : Map()));
  }

  void _handleMessage(Map<String, dynamic> data) {
    if (data['swa'] == "news") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NewsPage()));
    } else if (data['redirect'] == "product_details") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsPage(message: data['message'])));
    }
  }

  void animate() async {
    if (scrollController!.positions.isNotEmpty) {
      while (true) {
        await scrollController!.animateTo(0.0,
            duration: const Duration(seconds: 50), curve: Curves.ease);
        await scrollController!.animateTo(
            scrollController!.position.maxScrollExtent,
            duration: const Duration(minutes: 8),
            curve: Curves.linear);
      }
    } else {
      _timer = Timer(const Duration(milliseconds: 200), () {
        animate();
      });
    }
  }

  bool _isRefreshing = true;

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
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    context.read<CoinGet>().fetchData;
    context.read<ChartGet>().fetchData;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            Container(
              height: myHeight * 0.17,
              width: myWidth,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    height: myWidth * 0.06,
                    width: myWidth,
                    // color: Colors.amber,
                  ),
                  Container(
                    height: myHeight * 0.08,
                    width: myWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icon/Star.png",
                                  height: 30.0, color: Colors.amberAccent),
                              const Spacer(),
                              Image.asset(
                                "assets/icon/world.png",
                                height: 25.0,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "swaaaa.ir",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: myWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Consumer<ChartGet>(
                          builder: (context, value, child) {
                            return value.map.length == 0 && !value.error
                                ? Center(
                                    child: Lottie.asset(
                                        "assets/animation/loading.json",
                                        height: 40.0),
                                  )
                                : value.error
                                    ? Text(value.errorMessage.toString())
                                    : ListView.builder(
                                        reverse: true,
                                        itemCount: 50,
                                        controller: scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Center(
                                              child: value.map[index].name !=
                                                      null
                                                  ? Text(
                                                      value.map[index].name
                                                              .toString() +
                                                          r' :  $' +
                                                          value.map[index]
                                                              .currentPrice
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.9)),
                                                    )
                                                  : const Text("تعیین نشده"),
                                            ),
                                          );
                                        },
                                      );
                          },
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  height: myHeight * 0.17,
                  width: myWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Whale(),
                                  ));
                            },
                            child: Container(
                              height: myHeight * 0.07,
                              width: myWidth * 0.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "خرید نهنگ ها",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      "assets/icon/whale.png",
                                      height: 24.0,
                                      // color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewsPage(),
                                  ));
                            },
                            child: Container(
                              height: myHeight * 0.07,
                              width: myWidth * 0.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "اخبار",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: Colors.blueAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          "assets/icon/news.png",
                                          height: 22.0,
                                          // color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: myHeight * 0.07,
                            width: myWidth * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                  )
                                ]),
                          ),
                          Container(
                            height: myHeight * 0.07,
                            width: myWidth * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // color: Colors.amber,
                ),
                const Divider(indent: 10, endIndent: 10),
                ///////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  height: myHeight * 0.22,
                  width: myWidth,
                  // color: Colors.amber,
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: Center(
                      child: Consumer<CoinGet>(
                        builder: (context, value, child) {
                          return value.map.length == 0 && !value.error
                              ? Center(
                                  child: Lottie.asset(
                                      "assets/animation/loading.json",
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      "برترین ها",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "بیشتر ...",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color:
                                                            Colors.blueAccent,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: 10,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    CoinMarket coinMarket =
                                                        value.map[index];
                                                    var y = value.map[index]
                                                        .sparklineIn7D!.price;
                                                    var x = y!
                                                        .getRange(y.length - 30,
                                                            y.length)
                                                        .toList();
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => CoinSelect(
                                                                      changePrice: value
                                                                          .map[
                                                                              index]
                                                                          .marketCapChangePercentage24H!,
                                                                      price: value
                                                                          .map[
                                                                              index]
                                                                          .currentPrice,
                                                                      id: value
                                                                          .map[
                                                                              index]
                                                                          .id
                                                                          .toString()),
                                                                ));
                                                          },
                                                          child: Container(
                                                            height:
                                                                myHeight * 0.17,
                                                            width:
                                                                myWidth * 0.34,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                  )
                                                                ]),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              myHeight * 0.07,
                                                                          // width: myWidth*0.15
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                Sparkline(
                                                                              // data: coinMarket![index]
                                                                              //     .sparklineIn7D
                                                                              //     .price,
                                                                              data: x != null ? x : [],
                                                                              lineWidth: 1.5,
                                                                              fillGradient: LinearGradient(
                                                                                stops: const [
                                                                                  0,
                                                                                  0.8
                                                                                ],
                                                                                begin: Alignment.topCenter,
                                                                                end: Alignment.bottomCenter,
                                                                                colors: value.map[index].marketCapChangePercentage24H != null
                                                                                    ? value.map[index].marketCapChangePercentage24H! <= 0
                                                                                        ? redColor
                                                                                        : greenColor
                                                                                    : greyColor,
                                                                              ),
                                                                              fillMode: FillMode.below,
                                                                              useCubicSmoothing: true,
                                                                              cubicSmoothingFactor: 0.2,
                                                                              enableThreshold: true,
                                                                              lineColor: value.map[index].marketCapChangePercentage24H != null
                                                                                  ? value.map[index].marketCapChangePercentage24H! <= 0
                                                                                      ? Colors.red
                                                                                      : Colors.green
                                                                                  : Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20.0),
                                                                      Container(
                                                                        height: myHeight *
                                                                            0.04,
                                                                        width: myWidth *
                                                                            0.08,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                                                            image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(value.map[index].image.toString()))),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          const Spacer(),
                                                                          value.map[index].name != null
                                                                              ? Text(
                                                                                  value.map[index].name.toString(),
                                                                                  style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                                                )
                                                                              : const Text("تعیین نشده"),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Spacer(),
                                                                          value.map[index].currentPrice != null
                                                                              ? Text(
                                                                                  r'$ ' + value.map[index].currentPrice.toString(),
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                )
                                                                              : const Text("تعیین نشده"),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Spacer(),
                                                                      value.map[index].marketCapChangePercentage24H !=
                                                                              null
                                                                          ? Text(
                                                                              value.map[index].marketCapChangePercentage24H.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 12.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: value.map[index].marketCapChangePercentage24H! <= 0 ? Colors.red : Colors.green,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              "تعیین نشده"),
                                                                      Icon(
                                                                        value.map[index].marketCapChangePercentage24H !=
                                                                                null
                                                                            ? value.map[index].marketCapChangePercentage24H! <= 0
                                                                                ? Icons.arrow_drop_down_rounded
                                                                                : Icons.arrow_drop_up_rounded
                                                                            : Icons.minimize,
                                                                        color: value.map[index].marketCapChangePercentage24H !=
                                                                                null
                                                                            ? value.map[index].marketCapChangePercentage24H! <= 0
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
                    ),
                  ),
                ),
                // Bartarin(),
                FilterStaticFile.widgetBool[0] == true
                    ? SizedBox(height: myHeight * 0.05)
                    : const SizedBox(),
                FilterStaticFile.widgetBool[0] == true
                    ? SodAvartarin()
                    : const SizedBox(),
                FilterStaticFile.widgetBool[1] == true
                    ? SizedBox(height: myHeight * 0.05)
                    : const SizedBox(),
                FilterStaticFile.widgetBool[1] == true
                    ? Bazande()
                    : const SizedBox(),
                FilterStaticFile.widgetBool[2] == true
                    ? SizedBox(height: myHeight * 0.05)
                    : const SizedBox(),
                FilterStaticFile.widgetBool[2] == true
                    ? News()
                    : const SizedBox(),
                FilterStaticFile.widgetBool[3] == true
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Trends(),
                      )
                    : const SizedBox(),
                SizedBox(height: myHeight * 0.1),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FilterPage(),
                          ));
                    },
                    child: Container(
                      width: myWidth * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "سفارشی سازی",
                              style: TextStyle(color: Colors.black),
                            ),
                            Image.asset("assets/icon/Filter.png", height: 25.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  // List? coinTrend = [];
  // var coinTrendList;
  // var coinTrendData;
  // Future<List<Coin>?> getTrend() async {
  //   const infourl = 'https://api.coingecko.com/api/v3/search/trending';
  //   var response = await http.get(Uri.parse(infourl), headers: {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //   });
  //   if (response.statusCode == 200) {
  //     var x = json.decode(response.body);
  //     // var x = response.body;
  //     coinTrendList = x.map((e) => Coin.fromJson(e)).toList();
  //     // coinTrendList = trendingModelFromJson(x);
  //     setState(() {
  //       coinTrendData = coinTrendList;
  //     });
  //     return coinTrendData;
  //   }
  // }
  // var coinTrendList;
  // var coinTrendData;
  // List<Coin>? trendCoin;
  // Future<List<Coin>?> getTrend() async {
  //   const infourl = 'https://api.coingecko.com/api/v3/search/trending';
  //   var response = await http.get(Uri.parse(infourl), headers: {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //   });
  //   if (response.statusCode == 200) {
  //     var x = json.decode(response.body);
  //     // var x = response.body;
  //     coinTrendList = x.map((e) => Coin.fromJson(e)).toList();
  //     // coinTrendList = trendingModelFromJson(x);
  //     setState(() {
  //       trendCoin = coinTrendList;
  //     });
  //   }
  // }

  Widget SodAvartarin() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: myHeight * 0.2,
      width: myWidth,
      color: Colors.amber,
      child: const Center(
        child: Text("سود آورترین ها"),
      ),
    );
  }

  Widget Bazande() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: myHeight * 0.2,
      width: myWidth,
      color: Colors.amber,
      child: const Center(
        child: Text("بازنده ترین ها"),
      ),
    );
  }

  Widget News() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: myHeight * 0.2,
      width: myWidth,
      color: Colors.amber,
      child: const Center(
        child: Text("اخبار"),
      ),
    );
  }

  Widget Trend() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
        height: myHeight * 0.22,
        width: myWidth,
        color: Colors.amber,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Trend",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: ListView.builder(
              // itemCount: coinTrendData!.,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                      child: Container(
                    height: myHeight * 0.17,
                    width: myWidth * 0.34,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [],
                          )
                        ],
                      ),
                    ),
                  )),
                );
              },
            ))
          ],
        ));
  }
}
