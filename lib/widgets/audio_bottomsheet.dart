import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_holy_quran/providers/audio_provider.dart';
import 'package:the_holy_quran/widgets/seek_bar.dart';

import '../providers/locale_provider.dart';

class AudioBottomSheet extends StatelessWidget {
  const AudioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return SizedBox(
      height: 600,
      child: Selector<AudioProvider, bool>(
        selector: (context, provider) =>
            provider.audioPlayer.processingState == ProcessingState.completed,
        builder: (context, loading, child) {
          if (loading) {
            return const CircularProgressIndicator();
          } else {
            return Consumer<AudioProvider>(
              builder: (context, provider, child) => Column(
                children: [
                  const SizedBox(
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    provider.readerName ??
                        (isArabicLocale
                            ? provider.reader!.reciter.ar
                            : provider.reader!.reciter.en),
                  ),
                  Text(
                    provider.chapterName ??
                        (isArabicLocale
                            ? provider.chapter!.surahName.ar
                            : provider.chapter!.surahName.en),
                  ),
                  StreamBuilder<PositionData>(
                    stream: Rx.combineLatest3<Duration, Duration, Duration?,
                            PositionData>(
                        provider.audioPlayer.positionStream,
                        provider.audioPlayer.bufferedPositionStream,
                        provider.audioPlayer.durationStream,
                        (position, bufferedPosition, duration) => PositionData(
                            position,
                            bufferedPosition,
                            duration ?? Duration.zero)),
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                            positionData?.bufferedPosition ?? Duration.zero,
                        onChanged: provider.audioPlayer.seek,
                      );
                    },
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => provider.updateLoopMode(),
                        icon: Icon(
                          Icons.loop_outlined,
                          color: provider.audioPlayer.loopMode == LoopMode.one
                              ? Colors.green
                              : null,
                        ),
                      ),
                      IconButton(
                        onPressed: provider.playPreviuse,
                        icon: const Icon(Icons.skip_previous),
                      ),
                      IconButton(
                        onPressed: () => provider.playSwitch(),
                        icon: Icon(
                          provider.audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                      IconButton(
                        onPressed: provider.playNext,
                        icon: const Icon(Icons.skip_next),
                      ),
                      !provider.isFile
                          ? IconButton(
                              onPressed: provider.downloadFiles,
                              icon: const Icon(
                                Icons.file_download_outlined,
                                color: Colors.green,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
