import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coin/model/olhc_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OLHCPage extends StatefulWidget {
  const OLHCPage({Key? key}) : super(key: key);

  @override
  _OLHCPageState createState() => _OLHCPageState();
}

class _OLHCPageState extends State<OLHCPage> {
  late TrackballBehavior trackballBehavior;
  @override
  void initState() {
    getOLHC();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  // DateTime? myTime;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: myHeight * 0.3,
      width: double.infinity,
      child: (olhcChart == null)
          ? (Center(
              child:
                  Lottie.asset("assets/animation/loading.json", height: 40.0),
            ))
          : Column(
              children: [
                Container(
                  height: myHeight * 0.3,
                  child: SfCartesianChart(
                    trackballBehavior: trackballBehavior,
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true,
                      zoomMode: ZoomMode.x,
                    ),
                    series: <CandleSeries>[
                      CandleSeries<OlhcModel, int>(
                          // opacity: 0.2,
                          enableSolidCandles: true,
                          enableTooltip: true,
                          bullColor: Colors.green,
                          bearColor: Colors.redAccent,
                          animationDuration: 55.0,
                          dataSource: olhcChart!,
                          xValueMapper: (OlhcModel sales, _) => sales.time,
                          lowValueMapper: (OlhcModel sales, _) => sales.low,
                          highValueMapper: (OlhcModel sales, _) => sales.high,
                          openValueMapper: (OlhcModel sales, _) => sales.open,
                          closeValueMapper: (OlhcModel sales, _) => sales.close)
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  width: myWidth,
                  color: Colors.amber,
                ))
              ],
            ),
    );
  }

  List<OlhcModel>? olhcChart;
  // var olhcChartList;

  Future<void> getOLHC() async {
    String infourl =
        'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=1';
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      // var x = response.body;

      List<OlhcModel> modelList = x.map((e) => OlhcModel.fromJson(e)).toList();
      //  var slist= selectCoinModelFromJson(x);
      setState(() {
        olhcChart = modelList;
      });
      print("object");
      // return modelList;
    }
  }
}
