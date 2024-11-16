import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/config/theme_notifier.dart';
import 'package:the_holy_quran/models/surah_model.dart';
import 'package:the_holy_quran/util/to_arabic_num_converter.dart';

class VerseWidget extends StatelessWidget {
  final Verse verse;

  const VerseWidget(this.verse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: verse.verseText.ar),
          TextSpan(
            text: "\uFD3E${(verse.number + 1).toArabicNumbers}\uFD3F",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: "me_quran",
              fontSize: Provider.of<ThemeNotifier>(context).fontSize.toDouble(),
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
      ),
    );
  }
}
