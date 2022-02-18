import 'dart:developer';

import 'package:coin/page/Setting/setting_notification.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'setting_customize.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool switchTheme = false;
  bool switchLanguage = false;
  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingNotification(),
                    ));
              },
              child: SettingWidget(
                  "assets/icon/bold/Notification.png",
                  "notification".tr(),
                  theme.con2Color,
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.0,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingCustomize(),
                    ));
              },
              child: SettingWidget(
                  "assets/icon/Filter.png",
                  "customize".tr(),
                  theme.con2Color,
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.0,
                  )),
            ),
            SettingWidget(
                "assets/icon/theme.png",
                "theme".tr(),
                theme.conColor,
                Switch(
                    value: switchTheme,
                    activeColor: theme.iconColor,
                    onChanged: (bool value) {
                      setState(() {
                        switchTheme = value;
                      });
                      if (switchTheme == false) {
                        theme.defaltTheme();
                      } else if (switchTheme == true) {
                        theme.blackTheme();
                      }
                    })),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Text(
                        "selectLanguageSetting".tr(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: theme.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                _SwitchListTileMenuItem(
                    title: 'persian'.tr(),
                    image: 'assets/icon/translate.png',
                    locale: context.supportedLocales[0]),
                _SwitchListTileMenuItem(
                    title: "english".tr(),
                    image: 'assets/icon/translate.png',
                    locale: context.supportedLocales[1]),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget SettingWidget(String image, String title, Color color, Widget widget) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        height: myHeight * 0.07,
        width: myWidth,
        decoration: BoxDecoration(
          color: color,
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
                    image,
                    height: 20.0,
                    color: theme.iconColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                        color: theme.textColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatefulWidget {
  const _SwitchListTileMenuItem({
    Key? key,
    required this.title,
    required this.image,
    required this.locale,
  }) : super(key: key);

  final String title;
  final String image;
  final Locale locale;

  @override
  State<_SwitchListTileMenuItem> createState() =>
      _SwitchListTileMenuItemState();
}

class _SwitchListTileMenuItemState extends State<_SwitchListTileMenuItem> {
  bool isSelected(BuildContext context) => widget.locale == context.locale;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () async {
          log(widget.locale.toString(), name: toString());
          await context.setLocale(widget.locale);
          // Navigator.pop(context);
        },
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
                      widget.image,
                      height: 20.0,
                      color: theme.iconColor,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: theme.textColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isSelected(context)
                    ? Image.asset("assets/icon/TickSquare.png",
                        height: 25.0,
                        color:
                            isSelected(context) ? theme.iconColor : Colors.grey)
                    : Image.asset("assets/icon/CloseSquare.png",
                        height: 25.0,
                        color:
                            isSelected(context) ? theme.iconColor : Colors.grey)
              ],
            ),
          ),
          // decoration: BoxDecoration(
          //   border:
          //       isSelected(context) ? Border.all(color: Colors.blueAccent) : null,
          // ),
          // child: ListTile(
          //     dense: true,
          //     // isThreeLine: true,
          //     title: Text(
          //       widget.title,
          //     ),
          //     subtitle: Text(
          //       widget.subtitle,
          //     ),
          //     onTap: () async {
          //       log(widget.locale.toString(), name: toString());
          //       await context
          //           .setLocale(widget.locale); //BuildContext extension method
          //       Navigator.pop(context);
          //     }),
        ),
      ),
    );
  }
}
