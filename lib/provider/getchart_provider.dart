import 'dart:convert';

import 'package:coin/model/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ChartGet extends ChangeNotifier {
  List<CoinMarket> _map = [];
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  List<CoinMarket> get map => _map;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<CoinMarket>?> get fetchData async {
    _refresh = true;
    var response = await http.get(
        Uri.parse(
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    _refresh = false;
    // final res = await get(Uri.parse(
    //     "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true"));
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = coinMarketFromJson(x);
        _error = false;
        // _refresh = true;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = [];
      }
    } else {
      _error = false;
      _errorMessage = "Error : Conection Error";
      _map = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _map = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
