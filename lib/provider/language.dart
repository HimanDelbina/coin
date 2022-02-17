import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBloc extends ChangeNotifier {
  Locale _local = const Locale('fa', 'IR');
  Locale get local => _local;
  String _whale = "خرید نهنگ ها";
  String _whaleNotification = "اعلان خرید نهنگ ها";
  String _news = "اخبار";
  String _newsNotification = "اعلان اخبار";
  String _theme = "تم اپلیکیشن";
  String _notification = "اعلان ها";
  String _notificationSetting = "تنظیمات اعلان ها";
  String _textNotificationSetting =
      "شما میتوانید در این بخش تعیین کنید که چه اعلان هایی به شما نمایش داده شود .";
  String _language = "زبان";

  String get whale => _whale;
  String get whaleNotification => _whaleNotification;
  String get news => _news;
  String get newsNotification => _newsNotification;
  String get theme => _theme;
  String get notification => _notification;
  String get notificationSetting => _notificationSetting;
  String get textNotificationSetting => _textNotificationSetting;
  String get language => _language;

  set counter(String val) {
    _whale = val;
    _news = val;

    notifyListeners();
  }

  persianLanguage() {
    _local = const Locale('fa', 'IR');
    _whale = "خرید نهنگ ها";
    _whaleNotification = "اعلان خرید نهنگ ها";
    _news = "اخبار";
    _newsNotification = "اعلان اخبار";
    _theme = "تم اپلیکیشن";
    _notification = "اعلان ها";
    _notificationSetting = "تنظیمات اعلان ها";
    _textNotificationSetting =
        "شما میتوانید در این بخش تعیین کنید که چه اعلان هایی به شما نمایش داده شود .";
    _language = "زبان";
    notifyListeners();
    change_language_code("per");
  }

  englishLanguage() {
    _local = const Locale('en', 'US');
    _whale = "Buy whales";
    _whaleNotification = "Buy whales Notification";
    _news = "News";
    _newsNotification = "News Notification";
    _theme = "Theme";
    _notification = "Notifications";
    _notificationSetting = "Notification Setting";
    _textNotificationSetting =
        "In this section you can interpret what notifications are shown to you .";
    _language = "Language";
    notifyListeners();
    change_language_code("en");
  }

  change_language_code(String code) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("language_code", code);
  }
}
