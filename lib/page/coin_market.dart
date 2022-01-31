import 'dart:convert';
import 'package:coin/model/coin_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CoinMarketPage extends StatefulWidget {
  const CoinMarketPage({Key? key}) : super(key: key);

  @override
  _CoinMarketPageState createState() => _CoinMarketPageState();
}

class _CoinMarketPageState extends State<CoinMarketPage> {
  @override
  void initState() {
    super.initState();
   
   getcoinMarketLoop();
  }

  bool _isRefreshing = true;

   getcoinMarketLoop()async{
     while(true){
       await Future.delayed(Duration(seconds: 5));
       getcoinMarket();
     }
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
        // child: FutureBuilder<List<CoinMarket>?>(

        //     future: getcoinMarket(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return ListView.builder(
        //           // itemCount: coinMarket!.length,
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, index) {
        //             return Container(
        //               child:
        //                   Text(snapshot.data![index].currentPrice.toString()),
        //             );
        //           },
        //         );
        //       }
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }),
        // child: FutureBuilder<List<CoinMarket>?>(
        //   future: getcoinMarket(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       List<CoinMarket>? coin = snapshot.data;
        //       return Text(coin!.toString());
        //     }
        //     return const Center(child: CircularProgressIndicator());
        //   },
        // ),
        child: ListView.builder(
          itemCount: coinMarket!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (_isRefreshing)?(Center(child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()),)):Text(
                        coinMarket![index].currentPrice.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            coinMarket![index].name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            coinMarket![index].symbol.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(coinMarket![index].image.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinMarket>?> getcoinMarket() async {
    List<CoinMarket>? himan = [];
    // const infourl = 'http://128.65.186.187:1989/api/boperation';
    const infourl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';

        setState(() {
          _isRefreshing = true;
        });
    var response = await http.get(Uri.parse(infourl), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
        setState(() {
          _isRefreshing = false;
        });
    if (response.statusCode == 200) {
      // var x = json.decode(response.body);
      var x = response.body;
      // coinMarketList = x.map((e) => CoinMarket.fromJson(e)).toList();
      coinMarketList = coinMarketFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
        for (var item in coinMarketList) {
          himan.add(item);
        }
        print("himannnnnn");
      });
    }
    return himan;
  }
  // Future getcoinMarket() async {
  //   // const infourl = 'http://128.65.186.187:1989/api/boperation';
  //   const infourl =
  //       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
  //   var response = await http.get(Uri.parse(infourl), headers: {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //   });
  //   if (response.statusCode == 200) {
  //     // var x = json.decode(response.body);
  //     var x = response.body;
  //     // coinMarketList = x.map((e) => CoinMarket.fromJson(e)).toList();
  //     coinMarketList = coinMarketFromJson(x);
  //     setState(() {
  //       coinMarket = coinMarketList;
  //     });
  //     return coinMarket;
  //   }
  // }
}
