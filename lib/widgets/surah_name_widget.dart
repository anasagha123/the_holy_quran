import 'package:flutter/material.dart';
import 'package:the_holy_quran/config/responsive_font.dart';
import 'package:the_holy_quran/models/surah_model.dart';

import '../providers/locale_provider.dart';

class SurahNameWidget extends StatelessWidget {
  final SurahName name;

  const SurahNameWidget(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.008),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/surah_header.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        isArabicLocale ? name.ar : name.en,
        style: TextStyle(
          fontSize: getResponsiveFontSize(context, 32),
          color: Colors.black,
          fontFamily: "me_quran",
        ),
      ),
    );
  }
}
