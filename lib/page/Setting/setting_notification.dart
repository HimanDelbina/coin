import 'package:coin/provider/language.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingNotification extends StatefulWidget {
  const SettingNotification({Key? key}) : super(key: key);

  @override
  _SettingNotificationState createState() => _SettingNotificationState();
}

class _SettingNotificationState extends State<SettingNotification> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    LanguageBloc language = Provider.of<LanguageBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                height: myHeight * 0.15,
                width: myWidth,
                decoration: BoxDecoration(
                    color: theme.con2Color,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icon/Info2.png",
                            height: 25.0,
                            color: theme.iconColor,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "notificationSetting".tr(),
                            style: TextStyle(
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ],
                      ),
                      Text(
                        "textNotificationSetting".tr(),
                        style: TextStyle(
                            color: theme.textOpacityColor, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SettingNot(
                "assets/icon/bold/Notification.png",
                "newsNotification".tr(),
                Switch(
                  activeColor: theme.iconColor,
                  // activeTrackColor: Colors.green.withOpacity(0.2),
                  value: switchControlNews,
                  onChanged: (value) {
                    setState(() {
                      switchControlNews = value;
                    });
                  },
                )),
            SettingNot(
                "assets/icon/bold/Notification.png",
                "whaleNotification".tr(),
                Switch(
                  activeColor: theme.iconColor,
                  value: switchControlWall,
                  onChanged: (value) {
                    setState(() {
                      switchControlWall = value;
                    });
                  },
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    animCon = !animCon;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: animCon ? myHeight * 0.8 : myHeight * 0.06,
                  width: myWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: myHeight * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icon/bold/Notification.png",
                                    height: 20.0,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10.0),
                                  const Text(
                                    "اعلان رمز ارزها",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15.0,
                              )
                            ],
                          ),
                        ),
                        animCon
                            ? Expanded(
                                child: Container(
                                child: Column(
                                  children: [
                                    SettingNot(
                                        "assets/icon/bold/Notification.png",
                                        "بیتکوین",
                                        Switch(
                                          activeColor:
                                              Colors.green.withOpacity(0.5),
                                          activeTrackColor:
                                              Colors.green.withOpacity(0.2),
                                          value: switchControlBitCoin,
                                          onChanged: (value) {
                                            setState(() {
                                              switchControlBitCoin = value;
                                            });
                                          },
                                        )),
                                    SettingNot(
                                        "assets/icon/bold/Notification.png",
                                        "اتریوم",
                                        Switch(
                                          activeColor:
                                              Colors.green.withOpacity(0.5),
                                          activeTrackColor:
                                              Colors.green.withOpacity(0.2),
                                          value: switchControlEtherium,
                                          onChanged: (value) {
                                            setState(() {
                                              switchControlEtherium = value;
                                            });
                                          },
                                        )),
                                    SettingNot(
                                        "assets/icon/bold/Notification.png",
                                        "بایننس",
                                        Switch(
                                          activeColor:
                                              Colors.green.withOpacity(0.5),
                                          activeTrackColor:
                                              Colors.green.withOpacity(0.2),
                                          value: switchControlBNB,
                                          onChanged: (value) {
                                            setState(() {
                                              switchControlBNB = value;
                                            });
                                          },
                                        )),
                                    SettingNot(
                                        "assets/icon/bold/Notification.png",
                                        "کاردانو",
                                        Switch(
                                          activeColor:
                                              Colors.green.withOpacity(0.5),
                                          activeTrackColor:
                                              Colors.green.withOpacity(0.2),
                                          value: switchControlCardano,
                                          onChanged: (value) {
                                            setState(() {
                                              switchControlCardano = value;
                                            });
                                          },
                                        )),
                                  ],
                                ),
                              ))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool animCon = false;

  bool switchControlNews = true;
  bool switchControlWall = true;
  bool switchControlCoin = true;

  bool switchControlBitCoin = true;
  bool switchControlEtherium = true;
  bool switchControlBNB = true;
  bool switchControlCardano = true;

  Widget SettingNot(String icon, String title, Widget switchWidget) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    LanguageBloc language = Provider.of<LanguageBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
        height: myHeight * 0.07,
        width: myWidth,
        decoration: BoxDecoration(
          color: theme.conColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    height: 20.0,
                    color: theme.iconColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.textColor),
                  ),
                ],
              ),
              switchWidget
            ],
          ),
        ),
      ),
    );
  }
}
