import 'package:coin/model/whale_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Whale extends StatefulWidget {
  const Whale({Key? key}) : super(key: key);

  @override
  _WhaleState createState() => _WhaleState();
}

class _WhaleState extends State<Whale> {
  @override
  void initState() {
    super.initState();
    getWhale();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getWhale(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Lottie.asset("assets/animation/loading.json",
                      height: 40.0),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    spliteText(snapshot.data![index].persiantime!);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: snapshot.data[index].englishname! == "BTC"
                                ? Colors.blueAccent.withOpacity(0.1)
                                : snapshot.data[index].englishname! == "ETH"
                                    ? Colors.amber.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/Info2.png",
                                        height: 25.0,
                                        color: snapshot
                                                    .data[index].englishname! ==
                                                "BTC"
                                            ? Colors.blueAccent
                                            : snapshot.data[index]
                                                        .englishname! ==
                                                    "ETH"
                                                ? Colors.blueAccent
                                                : Colors.black.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        snapshot.data![index].persianame!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data[index].englishname!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text("تعداد رمز ارز انتقال داده شده : " +
                                  snapshot.data![index].coinnumber!
                                      .toString()
                                      .extractNumber()
                                      .seRagham()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("فرستنده : " +
                                      snapshot.data![index].sender!),
                                  Text("گیرنده : " +
                                      snapshot.data![index].reciver!),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value1!.toString().extractNumber() +
                                        ":" +
                                        value2!.toString().extractNumber(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                  Text(
                                    snapshot.data![index].date!
                                        .toString()
                                        .toPersianDate(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }

  String? value1;
  String? value2;
  void spliteText(String text) {
    final split = text.split(':');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    value1 = values[0];
    value2 = values[1];
  }

  List? whaleData = [];
  var whaleList;
  Future<List<WhaleModel>?> getWhale() async {
    const infourl = 'http://46.225.114.245:2002/wall/get_wall';
    var response = await http
        .get(Uri.parse(infourl), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var x = response.body;
      whaleList = whaleModelFromJson(x);
      setState(() {
        whaleData = whaleList;
      });
      return whaleList;
    }
  }
}
