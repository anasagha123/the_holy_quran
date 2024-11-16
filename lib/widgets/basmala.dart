import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/providers/quran_data.dart';

import '../config/theme_notifier.dart';
import '../providers/locale_provider.dart';

class Basmala extends StatelessWidget {
  const Basmala({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        isArabicLocale? QuranData.quran[0].verses[0].verseText.ar: QuranData.quran[0].verses[0].verseText.en,
        style: TextStyle(
          fontFamily: "me_quran",
          fontSize:
              Provider.of<ThemeNotifier>(context).fontSize.toDouble(),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
