import 'package:coin/page/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/theme.dart';
import 'first_page.dart';
import 'login.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? curveImage;
  Animation<double>? curveText;
  ColorTween? colorAnim;
  @override
  void initState() {
    super.initState();
    set_theme();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    curveImage = CurvedAnimation(parent: controller!, curve: Curves.linear);
    curveText = CurvedAnimation(parent: controller!, curve: Curves.linear);
    colorAnim = ColorTween(begin: Colors.red, end: Colors.amber);
    controller!.forward();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FirstPage()));
    });
  }

  void set_theme() async {
    await Future.delayed(const Duration(milliseconds: 50));
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var theme_code = _pref.getString("theme_code");
    final ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context, listen: false);

    switch (theme_code) {
      case "black":
        theme_Bloc.blackTheme();
        break;
      // case "blue":
      //   theme_Bloc.blueTheme();
      //   break;
      case "white":
        theme_Bloc.defaltTheme();
        break;
      default:
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Center(
              child: FadeTransition(
                opacity: curveImage!,
                child: Image.asset(
                  "assets/icon/world.png",
                  height: 100.0,
                ),
              ),
            ),
            FadeTransition(
              opacity: curveText!,
              child: const Text(
                "swaaaa.ir",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 20.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       const SizedBox(),
      //       Center(
      //         child: Image.asset(
      //           "assets/icon/world.png",
      //           height: 100.0,
      //         ),
      //       ),
      //       const Text(
      //         "swaaaa.ir",
      //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
