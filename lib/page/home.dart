import 'dart:async';
import 'dart:convert';
import 'package:coin/Notification/product_details.dart';
import 'package:coin/page/Coin/coin_10_first.dart';
import 'package:coin/page/Coin/trends.dart';
import 'package:coin/page/Whale/whale.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:coin/provider/getcoin_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'News/news.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  // final String? message;
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ScrollController? scrollController;

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

  @override
  Widget build(BuildContext context) {
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
                  Trends(),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
