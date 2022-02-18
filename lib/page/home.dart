import 'dart:async';
import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coin/Notification/product.dart';
import 'package:coin/Notification/product_details.dart';
import 'package:coin/model/coin_model.dart';
import 'package:coin/page/Coin/coin_10_first.dart';

import 'package:coin/page/Coin/coin_select.dart';

import 'package:coin/page/Coin/trends.dart';
import 'package:coin/page/Whale/whale.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:coin/provider/getcoin_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:coin/static/filter_static.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Coin/Chart/olhc_page.dart';
import 'News/news.dart';
import 'Setting/setting_customize.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  // final String? message;
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // AnimationController? _controller;
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

    // FilterStaticFile.widgetBool = [false, false, false, false];

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
    scrollController = ScrollController();
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

  // void animate() async {
  //   if (scrollController!.positions.isNotEmpty) {
  //     while (true) {
  //       await scrollController!.animateTo(0.0,
  //           duration: const Duration(seconds: 50), curve: Curves.ease);
  //       await scrollController!.animateTo(
  //           scrollController!.position.maxScrollExtent,
  //           duration: const Duration(minutes: 8),
  //           curve: Curves.linear);
  //     }
  //   } else {
  //     _timer = Timer(const Duration(milliseconds: 200), () {
  //       animate();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    context.read<CoinGet>().fetchData;
    context.read<ChartGet>().fetchData;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      conHome(
                          "whale".tr(), "assets/icon/whale.png", const Whale()),
                      conHome("news".tr(), "assets/icon/news.png",
                          const NewsPage()),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(indent: 10, endIndent: 10),
            Expanded(
              child: ListView(
                children: const [
                  Coin10First(),
                ],
              ),
            ),
            // Bartarin(),
            // FilterStaticFile.widgetBool[0] == true
            //     ? SizedBox(height: myHeight * 0.05)
            //     : const SizedBox(),
            // FilterStaticFile.widgetBool[0] == true
            //     ? SodAvartarin()
            //     : const SizedBox(),
            // FilterStaticFile.widgetBool[1] == true
            //     ? SizedBox(height: myHeight * 0.05)
            //     : const SizedBox(),
            // FilterStaticFile.widgetBool[1] == true
            //     ? Bazande()
            //     : const SizedBox(),
            // FilterStaticFile.widgetBool[2] == true
            //     ? SizedBox(height: myHeight * 0.05)
            //     : const SizedBox(),
            // FilterStaticFile.widgetBool[2] == true ? News() : const SizedBox(),
            // FilterStaticFile.widgetBool[3] == true
            //     ? const Padding(
            //         padding: EdgeInsets.symmetric(vertical: 10.0),
            //         child: Trends(),
            //       )
            //     : const SizedBox(),
          ],
        ),
      ),
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const FilterPage(),
      //         ));
      //   },
      //   child: Container(
      //     width: myWidth * 0.35,
      //     decoration: BoxDecoration(
      //       color: Colors.grey.withOpacity(0.1),
      //       borderRadius: BorderRadius.circular(50.0),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 7.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           const Text(
      //             "سفارشی سازی",
      //             style: TextStyle(color: Colors.black),
      //           ),
      //           Image.asset("assets/icon/Filter.png", height: 25.0)
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget conHome(String title, String image, Widget widget) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ));
      },
      child: Container(
        height: myHeight * 0.07,
        width: myWidth * 0.45,
        decoration: BoxDecoration(
          color: theme.conColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: theme.textColor),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Image.asset(
                image,
                height: 24.0,
              ),
            )
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
