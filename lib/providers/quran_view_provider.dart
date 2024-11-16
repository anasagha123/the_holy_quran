

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_holy_quran/models/quran_view.dart';

class QuranViewProvider with ChangeNotifier{
  static QuranView quranView = QuranView.complete;
  static Map<String, QuranView> getFromString = {
    QuranView.complete.toString(): QuranView.complete,
    QuranView.pages.toString(): QuranView.pages,
  };

  Future<void> setQuranView(QuranView? quranView) async {
    QuranViewProvider.quranView = quranView!;
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("quran_view", quranView.toString());
    notifyListeners();
  }

  static Future<void> getQuranView() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? quranViewString = sharedPref.getString("quran_view");
    quranView = getFromString[quranViewString]?? QuranView.complete;
  }
}