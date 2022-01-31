import 'package:coin/page/first_page.dart';
import 'package:coin/static/filter_static.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int? widgetShowInt = 0;
  List<bool> widgetShow = [false, false, false, false];
  List<bool>? showWidget = [];

  @override
  void initState() {
    super.initState();
    if (FilterStaticFile.widgetBool.length == 0) {
      showWidget = widgetShow;
    } else {
      showWidget = FilterStaticFile.widgetBool;
    }
    print(showWidget);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: myHeight * 0.05,
              width: myWidth,
              // color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FilterStaticFile.widgetBool = showWidget!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FirstPage(),
                            ));
                      },
                      child: const Text(
                        "ذخیره",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                height: myHeight * 0.15,
                width: myWidth,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icon/Info2.png",
                            height: 25.0,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            "سفارشی سازی صفحه اصلی",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                      const Text(
                        "شما میتوانید صفحه اصلی اپلیکیشن را با اضافه یا حذف کردن آیتم ها سفارشی کنید .",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "نمایش در صفحه اصلی",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icon/Tick.png",
                                height: 30.0,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 15.0),
                              Image.asset(
                                "assets/icon/cup1.png",
                                height: 25.0,
                                // color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 5.0),
                              const Text(
                                "برترین ها",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          showWidget![0] == true
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![0] == true
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![0] = false;
                                    });
                                    print(showWidget);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Close.png",
                                        height: 30.0,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/chartUp.png",
                                        height: 25.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 5.0),
                                      const Text(
                                        "سود آورترین ها",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![1] == true
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![1] == true
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![1] = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Close.png",
                                        height: 30.0,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/chartDown.png",
                                        height: 25.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 5.0),
                                      const Text(
                                        "بازنده ترین ها",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![2] == true
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![2] == true
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![2] = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Close.png",
                                        height: 30.0,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/news.png",
                                        height: 20.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 7.0),
                                      const Text(
                                        "اخبار",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![3] == true
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![3] == true
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![3] = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Close.png",
                                        height: 30.0,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/trend.png",
                                        height: 20.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 7.0),
                                      const Text(
                                        "trend",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "انتخاب های بیشتر",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        children: [
                          showWidget![0] == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![0] = true;
                                    });
                                    print(showWidget);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Plus.png",
                                        height: 30.0,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/chartUp.png",
                                        height: 25.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 5.0),
                                      const Text(
                                        "سود آورترین ها",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![0] == false
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![1] == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![1] = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Plus.png",
                                        height: 30.0,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/chartDown.png",
                                        height: 25.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 5.0),
                                      const Text(
                                        "بازنده ترین ها",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![1] == false
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![2] == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![2] = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Plus.png",
                                        height: 30.0,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/news.png",
                                        height: 20.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 7.0),
                                      const Text(
                                        "اخبار",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          showWidget![2] == false
                              ? const Divider()
                              : const SizedBox(),
                          showWidget![3] == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showWidget![3] = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Plus.png",
                                        height: 30.0,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Image.asset(
                                        "assets/icon/trend.png",
                                        height: 20.0,
                                        // color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 7.0),
                                      const Text(
                                        "trend",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
