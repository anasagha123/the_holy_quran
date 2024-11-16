import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/config/theme_notifier.dart';
import 'package:the_holy_quran/models/surah_model.dart';
import 'package:the_holy_quran/providers/locale_provider.dart';
import 'package:the_holy_quran/util/to_arabic_num_converter.dart';
import 'package:the_holy_quran/widgets/basmala.dart';
import 'package:the_holy_quran/widgets/surah_name_widget.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;

  const SurahWidget(this.surah, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SurahNameWidget(surah.surahName),
        !{1, 9}.contains(surah.number) ? const Basmala() : const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text.rich(
            textAlign: TextAlign.justify,
            style: TextStyle(
              height: 2,
              fontFamily: "me_quran",
              fontSize: Provider.of<ThemeNotifier>(context).fontSize.toDouble(),
            ),
            TextSpan(
              children: Iterable.generate(surah.versesCount, (i) => i)
                  .expand(
                    (i) => [
                      TextSpan(
                          text: isArabicLocale
                              ? surah.verses[i].verseText.ar
                              : surah.verses[i].verseText.en,),
                      TextSpan(
                        text: isArabicLocale
                            ? " \uFD3F${(i + 1).toArabicNumbers}\uFD3E "
                            : " \u0028${i + 1}\u0029 ",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          shadows: const [
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Colors.amberAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
