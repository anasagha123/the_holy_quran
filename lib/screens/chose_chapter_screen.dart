import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/providers/audio_provider.dart';
import 'package:the_holy_quran/providers/quran_data.dart';
import 'package:the_holy_quran/widgets/audio_bottomsheet.dart';

import '../providers/locale_provider.dart';
import '../widgets/audio_controlls.dart';

class ChoseChapterScreen extends StatelessWidget {
  static const routeName = "/chapters_list";

  const ChoseChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: QuranData.quran.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Provider.of<AudioProvider>(context, listen: false)
                    .setUrlAudio(QuranData.quran[index]);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AudioBottomSheet(),
                );
              },
              leading: Text("${index + 1}"),
              title: Text(
                isArabicLocale
                    ? QuranData.quran[index].surahName.ar
                    : QuranData.quran[index].surahName.en,
              ),
              trailing: Consumer<AudioProvider>(
                builder: (context, provider, child) {
                  if (provider.chapter == QuranData.quran[index] &&
                      provider.audioPlayer.playing) {
                    return IconButton(
                      onPressed: () => provider.playSwitch(),
                      icon: const Icon(Icons.pause),
                    );
                  } else {
                    return IconButton(
                      onPressed: () =>
                          provider.setUrlAudio(QuranData.quran[index]).then(
                                (val) => provider.playSwitch(),
                              ),
                      icon: const Icon(Icons.play_arrow),
                    );
                  }
                },
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AudioControls(),
          ),
        ],
      ),
    );
  }
}
