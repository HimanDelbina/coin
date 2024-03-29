import 'package:coin/page/Setting/setting.dart';
import 'package:coin/page/first_page.dart';
import 'package:coin/page/logo.dart';
import 'package:coin/provider/check_internet.dart';
import 'package:coin/provider/getchart_provider.dart';
import 'package:coin/provider/gettrends_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'page/Setting/setting_customize.dart';
import 'provider/getcoin_provider.dart';
import 'provider/getexchange_provider.dart';
import 'provider/page_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic("flutter-notification");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification', // id
        'flutter_notification_title', // title
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'EN'),
      ],
      path: "assets/resourse",
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider<PageProvider>.value(
          value: PageProvider(),
        ),
        ChangeNotifierProvider<CoinGet>.value(
          value: CoinGet(),
        ),
        ChangeNotifierProvider<ExchangeGet>.value(
          value: ExchangeGet(),
        ),
        ChangeNotifierProvider<ChartGet>.value(
          value: ChartGet(),
        ),
        ChangeNotifierProvider<TrendsGet>.value(
          value: TrendsGet(),
        ),
        ChangeNotifierProvider<ThemeBloc>.value(
          value: ThemeBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Vazir"),
        home: const Logo(),
        // home: const SettingPage(),
        // home: const FirstPage(),
      ),
    );
  }
}
