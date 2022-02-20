import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends ChangeNotifier {
  String? _selectedTheme = "white";
  String get selectedTheme => _selectedTheme!;

  Color _backgroundColor = Colors.white;
  Color _tophomeColor = const Color(0xff23272C);
  Color _textColor = Colors.black;
  Color _textOpacityColor = Colors.grey;
  Color _textMoreColor = Colors.blueGrey;
  Color _iconColor = Colors.blueAccent;
  Color _conColor = Colors.grey.withOpacity(0.1);
  Color _con2Color = Colors.blueAccent.withOpacity(0.1);
  Color _navBarSelectedColor = Colors.black;
  Color _navBarUnSelectedColor = Colors.grey;
  Color _moreColor = Colors.blueAccent;

  Color get backgroundColor => _backgroundColor;
  Color get tophomeColor => _tophomeColor;
  Color get textColor => _textColor;
  Color get textOpacityColor => _textOpacityColor;
  Color get textMoreColor => _textMoreColor;
  Color get iconColor => _iconColor;
  Color get conColor => _conColor;
  Color get con2Color => _con2Color;
  Color get navBarSelectedColor => _navBarSelectedColor;
  Color get navBarUnSelectedColor => _navBarUnSelectedColor;
  Color get moreColor => _moreColor;

  Future<void> setTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_code', selectedTheme);
  }

  set counter(Color val) {
    _backgroundColor = val;
    notifyListeners();
  }

  set counterSelected(String val) {
    _selectedTheme = val;
    notifyListeners();
  }

  defaltTheme() {
    _backgroundColor = Colors.white;
    _textColor = Colors.black;
    _textOpacityColor = Colors.grey;
    _tophomeColor = const Color(0xff23272C);
    _textMoreColor = Colors.blueGrey;
    _iconColor = Colors.blueAccent;
    _conColor = Colors.grey.withOpacity(0.1);
    _con2Color = Colors.blueAccent.withOpacity(0.1);
    _navBarSelectedColor = Colors.black;
    _navBarUnSelectedColor = Colors.grey;
    _moreColor = Colors.blueAccent;

    _selectedTheme = "white";
    setTheme();
    notifyListeners();
    change_theme_code("white");
  }

  blackTheme() {
    _backgroundColor = const Color(0xff23272C);
    _textColor = const Color(0xffd0d0d0);
    _textOpacityColor = Colors.grey;
    _tophomeColor = const Color(0xFFEFEFEF);
    _textMoreColor = Colors.blueGrey;
    _iconColor = Colors.redAccent;
    _conColor = const Color(0xff3F4348);
    _con2Color = Colors.blueAccent.withOpacity(0.1);
    _navBarSelectedColor = const Color(0xffd0d0d0);
    _navBarUnSelectedColor = const Color(0xff3F4348);
    _moreColor = Colors.blueAccent;

    _selectedTheme = "black";
    setTheme();
    notifyListeners();
    change_theme_code("black");
  }

  change_theme_code(String code) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("theme_code", code);
  }
  // blueTheme() {
  //   _backgroundColor = Colors.blue;
  //   _selectedTheme = "blue";
  //   setTheme();
  //   notifyListeners();
  //   change_theme_code("blue");
  // }
}
