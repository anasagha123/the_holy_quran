import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_holy_quran/providers/audio_provider.dart';
import 'package:the_holy_quran/widgets/audio_bottomsheet.dart';

import '../providers/locale_provider.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioProvider>(context);
    final isArabicLocale = LocaleProvider.locale.languageCode == "ar";

    return audioPlayerProvider.chapter != null || audioPlayerProvider.chapterName !=null
        ? GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => const AudioBottomSheet(),
            ),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            audioPlayerProvider.readerName ??
                                (isArabicLocale
                                    ? audioPlayerProvider.reader!.reciter.ar
                                    : audioPlayerProvider.reader!.reciter.en),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            audioPlayerProvider.chapterName ??
                                (isArabicLocale
                                    ? audioPlayerProvider.chapter!.surahName.ar
                                    : audioPlayerProvider
                                        .chapter!.surahName.en),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_previous,
                            color: Colors.white),
                        onPressed: audioPlayerProvider.playPreviuse,
                      ),
                      IconButton(
                        icon: Icon(
                          audioPlayerProvider.audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: audioPlayerProvider.playSwitch,
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: audioPlayerProvider.playNext,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: audioPlayerProvider.closeControls,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // top: ,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: StreamBuilder<PositionData>(
                      stream: Rx.combineLatest3<Duration, Duration, Duration?,
                              PositionData>(
                          audioPlayerProvider.audioPlayer.positionStream,
                          audioPlayerProvider
                              .audioPlayer.bufferedPositionStream,
                          audioPlayerProvider.audioPlayer.durationStream,
                          (position, bufferedPosition, duration) =>
                              PositionData(position, bufferedPosition,
                                  duration ?? Duration.zero)),
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return LinearProgressIndicator(
                          value: (positionData?.position.inMilliseconds
                                      .toDouble() ??
                                  0) /
                              (positionData?.duration.inMilliseconds
                                      .toDouble() ??
                                  1),
                          color: Colors.green,
                          backgroundColor: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
