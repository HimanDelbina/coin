import 'package:coin/model/exchange_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  void initState() {
    super.initState();
    getExchange();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: myHeight,
          width: myWidth,
          child: ListView.builder(
            itemCount: exchange!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: AnimatedContainer(
                      // height: myHeight * 0.1,
                      width: myWidth,
                      duration: const Duration(milliseconds: 400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                exchange![index].yearEstablished == null
                                    ? const Text(
                                        "سال تاسیس : " + "مشخص نیست",
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 12.0),
                                      )
                                    : Text(
                                        "سال تاسیس : " +
                                            exchange![index]
                                                .yearEstablished
                                                .toString(),
                                        style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 12.0),
                                      ),
                                Text(
                                  "رتبه اعتماد : " +
                                      exchange![index].trustScore.toString(),
                                  style: const TextStyle(
                                      color: Colors.blueGrey, fontSize: 12.0),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  exchange![index].name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Center(
                                      child: Text(
                                        '#' +
                                            exchange![index]
                                                .trustScoreRank
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 15.0),
                            Container(
                              height: myHeight * 0.06,
                              width: myWidth * 0.12,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          exchange![index].image))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List? exchange = [];
  List? exchangeList = [];
  Future<List<ExchangeModel>?> getExchange() async {
    const infourl = 'https://api.coingecko.com/api/v3/exchanges';

    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      // var x = json.decode(response.body);
      var x = response.body;
      // coinMarketList = x.map((e) => CoinMarket.fromJson(e)).toList();
      exchangeList = exchangeModelFromJson(x);
      setState(() {
        exchange = exchangeList;
      });
    }
  }
}

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   void initState() {
//     super.initState();
//     getOLHC();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: SfCartesianChart(
//           series: <CandleSeries>[
//             CandleSeries<OlhcModel, DateTime>(
//               dataSource: olhcChart,
//               highValueMapper: (OlhcModel value, _) => value.high,
//               lowValueMapper: (OlhcModel value, _) => value.low,
//               openValueMapper: (OlhcModel value, _) => value.open,
//               closeValueMapper: (OlhcModel value, _) => value.close,
//             ),
//           ],
//           primaryXAxis: DateTimeAxis(),
//         ),
//       ),
//     );
//   }
// }

// var olhcChart;
// var olhcChartList;

// Future<OlhcModel?> getOLHC() async {
//   String infourl =
//       'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=1';
//   var response = await http.get(Uri.parse(infourl), headers: {
//     "Content-Type": "application/json",
//     "Accept": "application/json",
//   });
//   if (response.statusCode == 200) {
//     var x = json.decode(response.body);
//     // var x = response.body;

//     var olhcChart = x.map((e) => OlhcModel.fromJson(e)).toList();
//     //  var slist= selectCoinModelFromJson(x);
//     // setState(() {
//     //   olhcChart = x;
//     // });
//     print("object");
//     return olhcChart;
//   }
// }

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black54),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           body: ListView(
//         children: List.generate(
//             100, (i) => AnimatedListItem(i, key: ValueKey<int>(i))),
//       )),
//     );
//   }
// }

// class AnimatedListItem extends StatefulWidget {
//   final int? index;

//   AnimatedListItem(this.index, {Key? key}) : super(key: key);

//   @override
//   _AnimatedListItemState createState() => _AnimatedListItemState();
// }

// class _AnimatedListItemState extends State<AnimatedListItem> {
//   bool _animate = false;

//   static bool _isStart = true;

//   @override
//   void initState() {
//     super.initState();
//     _isStart
//         ? Future.delayed(Duration(milliseconds: widget.index! * 200), () {
//             setState(() {
//               _animate = true;
//               _isStart = false;
//             });
//           })
//         : _animate = true;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 1000),
//       opacity: _animate ? 1 : 0,
//       curve: Curves.easeInOutQuart,
//       child: AnimatedPadding(
//         duration: const Duration(milliseconds: 1000),
//         padding: _animate
//             ? const EdgeInsets.all(4.0)
//             : const EdgeInsets.only(top: 10),
//         child: Container(
//           constraints: const BoxConstraints.expand(height: 100),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 widget.index.toString(),
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
