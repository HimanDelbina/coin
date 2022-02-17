import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends ChangeNotifier {
  String? _selectedTheme = "white";
  String get selectedTheme => _selectedTheme!;

  Color _backgroundColor = Colors.white;
  Color _tophomeColor = const Color(0xff23272C);
  Color _textColor = Colors.black;
  Color _textOpacityColor = Colors.grey;
  Color _iconColor = Colors.blueAccent;
  Color _conColor = Colors.grey.withOpacity(0.1);
  Color _con2Color = Colors.blueAccent.withOpacity(0.1);

  Color get backgroundColor => _backgroundColor;
  Color get tophomeColor => _tophomeColor;
  Color get textColor => _textColor;
  Color get textOpacityColor => _textOpacityColor;
  Color get iconColor => _iconColor;
  Color get conColor => _conColor;
  Color get con2Color => _con2Color;

  Future<void> setTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', selectedTheme);
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
    _textColor = Colors.black;_textOpacityColor = Colors.grey;
    _tophomeColor = const Color(0xff23272C);
    _iconColor = Colors.blueAccent;
    _conColor = Colors.grey.withOpacity(0.1);
    _con2Color = Colors.blueAccent.withOpacity(0.1);

    _selectedTheme = "white";
    setTheme();
    notifyListeners();
    change_theme_code("white");
  }

  blackTheme() {
    _backgroundColor = const Color(0xff23272C);
    _textColor =const Color(0xffd0d0d0);_textOpacityColor = Colors.grey;
    _tophomeColor = const Color(0xFFEFEFEF);
    _iconColor = Colors.redAccent;
    _conColor =const Color(0xff3F4348);
    // _con2Color = Color(0xff262A2D);
    _con2Color = Colors.blueAccent.withOpacity(0.1);
    

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
