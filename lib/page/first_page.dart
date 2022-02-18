import 'package:coin/main.dart';
import 'package:coin/page/Coin/chart.dart';
import 'package:coin/page/home.dart';
import 'package:coin/page/profile.dart';
import 'package:coin/page/Coin/exchange_page.dart';
import 'package:coin/provider/page_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int selectedIndex = 2;
  Widget myProfile = const Profile();
  // Widget myTest = const Test();
  Widget myHome = const Home();
  Widget myChart = const Chart();

  @override
  void initState() {
    super.initState();
    selectedIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final PageProvider page = Provider.of<PageProvider>(context);
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: myWidth,
            child: page.pageShow,
          )),
          const Divider(),
          Container(
            height: myHeight * 0.07,
            width: myWidth,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    page.profile();
                  },
                  child: Image.asset(
                    "assets/icon/bold/Profile.png",
                    color: selectedIndex == 0
                        ? theme.navBarSelectedColor
                        : theme.navBarUnSelectedColor,
                    height: selectedIndex == 0 ? 30 : 27,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    page.setting();
                  },
                  child: Image.asset(
                    "assets/icon/bold/Setting.png",
                    color: selectedIndex == 1
                        ? theme.navBarSelectedColor
                        : theme.navBarUnSelectedColor,
                    height: selectedIndex == 1 ? 30 : 27,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    page.home();
                  },
                  child: Image.asset(
                    "assets/icon/bold/Home.png",
                    color: selectedIndex == 2
                        ? theme.navBarSelectedColor
                        : theme.navBarUnSelectedColor,
                    height: selectedIndex == 2 ? 30 : 27,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    page.chart();
                  },
                  child: Image.asset(
                    "assets/icon/bold/Chart.png",
                    color: selectedIndex == 3
                        ? theme.navBarSelectedColor
                        : theme.navBarUnSelectedColor,
                    height: selectedIndex == 3 ? 30 : 27,
                  ),
                ),
                Image.asset(
                  "assets/icon/bold/Logout.png",
                  color: theme.navBarUnSelectedColor,
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
