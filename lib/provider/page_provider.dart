import 'package:coin/page/Coin/chart.dart';
import 'package:coin/page/Setting/setting.dart';
import 'package:coin/page/home.dart';
import 'package:coin/page/profile.dart';
import 'package:coin/page/Coin/exchange_page.dart';
import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier {
  Widget _pageShow = const Home();
  int _pageIndex = 0;

  Widget get pageShow => _pageShow;
  int get pageIndex => _pageIndex;

  set counter(var val) {
    _pageShow = val;
    notifyListeners();
  }

  set counterIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  profile() {
    _pageShow = const Profile();
    _pageIndex = 0;
    notifyListeners();
  }

  setting() {
    _pageShow = const SettingPage();
    _pageIndex = 1;
    notifyListeners();
  }

  home() {
    _pageShow = const Home();
    _pageIndex = 2;
    notifyListeners();
  }

  chart() {
    _pageShow = const Chart();
    _pageIndex = 3;
    notifyListeners();
  }

  exit() {
    // _pageShow = const History();
    _pageIndex = 4;
    notifyListeners();
  }
}
