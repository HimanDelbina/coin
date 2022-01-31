import 'package:flutter/material.dart';

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
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    curveImage = CurvedAnimation(parent: controller!, curve: Curves.linear);
    curveText = CurvedAnimation(parent: controller!, curve: Curves.linear);
    colorAnim = ColorTween(begin: Colors.red, end: Colors.amber);
    controller!.forward();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
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
