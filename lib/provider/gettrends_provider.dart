import 'dart:convert';

import 'package:coin/model/coin_model.dart';
import 'package:coin/model/trending_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TrendsGet extends ChangeNotifier {
  TrendingModel? _map;
  TrendingModel? _mapNull;
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  TrendingModel? get map => _map;
  TrendingModel? get mapNull => _mapNull;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<TrendingModel>?> get fetchData async {
    _refresh = true;
    var response = await http.get(
        Uri.parse("https://api.coingecko.com/api/v3/search/trending"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    _refresh = false;
    // final res = await get(Uri.parse(
    //     "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true"));
    if (response.statusCode == 200) {
      try {
        var x = json.decode(response.body);
        _map = TrendingModel.fromJson(x);
        _error = false;
        // _refresh = true;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = _mapNull;
      }
    } else {
      _error = false;
      _errorMessage = "Error : Conection Error";
      _map = _mapNull;
    }
    notifyListeners();
  }

  void initialValues() {
    _map = _mapNull;
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
