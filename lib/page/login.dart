import 'package:coin/page/signup.dart';
import 'package:coin/provider/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'first_page.dart';
import '../internet/no_internet.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  final formkey = GlobalKey<FormState>();
  String? name;
  TextEditingController controllerName = TextEditingController();
  String? password;
  TextEditingController controllerPassword = TextEditingController();

  bool validAndSaveUser() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validAndSubmitUser() {
    if (validAndSaveUser()) {
      formkey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: myHeight,
          width: myWidth,
          child: login(),
        ),
      ),
    );
  }

  Widget login() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "swaaaa.ir",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      const SizedBox(height: 50.0),
                      Image.asset(
                        "assets/icon/world.png",
                        height: 100.0,
                      ),
                      const SizedBox(height: 50.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          maxLength: 11,
                          decoration: const InputDecoration(
                            helperText: 'لطفاشماره موبایل خود را وارد کنید',
                            hintText: "شماره موبایل",
                            hintStyle: TextStyle(fontSize: 14.0),
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(Icons.phone)),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "رمز عبور",
                            hintStyle: TextStyle(fontSize: 14.0),
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(Icons.password)),
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: myHeight * 0.15,
                    width: myWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              const Text("ساخت حساب کاربری"),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ));
                                },
                                child: const Text(
                                  "ثبت نام",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            // onTap: validAndSubmitUser,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FirstPage(),
                                  ));
                            },
                            child: Container(
                              height: myHeight * 0.08,
                              width: myWidth,
                              decoration: BoxDecoration(
                                  color: Color(0xff082032),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Center(
                                child: Text(
                                  "ورود",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : const NoInternet();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
