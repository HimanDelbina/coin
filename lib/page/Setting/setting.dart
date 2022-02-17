import 'package:coin/page/Setting/setting_notification.dart';
import 'package:coin/provider/language.dart';
import 'package:coin/provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    LanguageBloc language = Provider.of<LanguageBloc>(context);
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
                  language.notification,
                  theme.con2Color,
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.0,
                  )),
            ),
            SettingWidget(
                "assets/icon/theme.png",
                language.theme,
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
            SettingWidget(
                "assets/icon/language.png",
                language.language,
                theme.conColor,
                Switch(
                    value: switchLanguage,
                    activeColor: theme.iconColor,
                    onChanged: (bool value) {
                      setState(() {
                        switchLanguage = value;
                      });
                      if (switchLanguage == false) {
                        language.persianLanguage();
                      } else if (switchLanguage == true) {
                        language.englishLanguage();
                      }
                    })),
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
