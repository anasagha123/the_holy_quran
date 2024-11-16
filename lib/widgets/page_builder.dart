import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/models/surah_model.dart';
import 'package:the_holy_quran/providers/quran_data.dart';
import 'package:the_holy_quran/util/to_arabic_num_converter.dart';
import 'package:the_holy_quran/widgets/basmala.dart';
import 'package:the_holy_quran/widgets/surah_name_widget.dart';

import '../config/theme_notifier.dart';
import '../providers/locale_provider.dart';

class PageBuilder extends StatefulWidget {
  final int page;

  const PageBuilder(this.page, {super.key});

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  List<Verse> verses = [];
  List<Surah> surahs = [];

  @override
  void initState() {
    for (var surah in QuranData.quran) {
      for (var verse in surah.verses) {
        if (verse.page == widget.page) {
          verses.add(verse);
          if (verse.number == 1) {
            surahs.add(surah);
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return SingleChildScrollView(
      child: surahs.isEmpty
          ? Padding(
            padding: const EdgeInsets.all(12),
            child: Text.rich(
                    style: TextStyle(
            height: 2,
            fontFamily: "me_quran",
            fontSize: Provider.of<ThemeNotifier>(context).fontSize.toDouble(),
                    ),
                    textAlign: TextAlign.justify,
                    TextSpan(
            children: Iterable.generate(verses.length, (i) => i)
                .expand(
                  (index) => [
                TextSpan(
                  text: isArabicLocale
                      ? verses[index].verseText.ar
                      : verses[index].verseText.en,
                ),
                TextSpan(
                  text: isArabicLocale
                      ? " \uFD3F${(index + 1).toArabicNumbers}\uFD3E "
                      : " \u0028${index + 1}\u0029 ",
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
          )
          : Column(
        children: Iterable.generate(surahs.length, (i) => i)
            .expand(
              (index) => [
            SurahNameWidget(surahs[index].surahName),
            !{1, 9}.contains(surahs[index].number)
                ? const Basmala()
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text.rich(
                textAlign: TextAlign.justify,
                style: TextStyle(
                  height: 2,
                  fontFamily: "me_quran",
                  fontSize: Provider.of<ThemeNotifier>(context)
                      .fontSize
                      .toDouble(),
                ),
                TextSpan(
                  children: Iterable.generate(
                      surahs[index]
                          .verses
                          .where((e) => e.page == widget.page)
                          .length,
                          (i) => i).expand(
                        (verseIndex) {
                      List<Verse> verses = surahs[index]
                          .verses
                          .where((e) => e.page == widget.page)
                          .toList();
                      return [
                        TextSpan(
                          text: isArabicLocale
                              ? verses[verseIndex].verseText.ar
                              : verses[verseIndex].verseText.en,
                        ),
                        TextSpan(
                          text: isArabicLocale
                              ? " \uFD3F${(verses[verseIndex].number).toArabicNumbers}\uFD3E "
                              : " \u0028${(verses[verseIndex].number)}\u0029 ",
                          style: TextStyle(
                            color: Theme.of(context).brightness ==
                                Brightness.dark
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
                      ];
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        )
            .toList(),
      ),
    );
  }
}
