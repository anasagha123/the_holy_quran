import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier{
  static late Locale locale;

  Future<void> changeLocale(Locale? locale) async {
    LocaleProvider.locale= locale!;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("locale", locale.languageCode);
    notifyListeners();
  }

  static Future<void> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String defaultLocale = {"en", "ar"}.contains(Platform.localeName.substring(0, 2))? Platform.localeName.substring(0, 2): "ar";
    locale = Locale(sharedPreferences.getString("locale") ?? defaultLocale);
  }
}