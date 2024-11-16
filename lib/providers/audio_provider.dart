import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:just_audio/just_audio.dart';
import 'package:the_holy_quran/models/reader_model.dart';
import 'package:the_holy_quran/models/surah_model.dart';
import 'package:the_holy_quran/providers/quran_data.dart';

import 'locale_provider.dart';

class AudioProvider with ChangeNotifier {
  ReaderModel? reader;
  Surah? chapter;
  bool isFile = false;
  String? readerName;
  String? chapterName;
  String? filePath;
  final audioPlayer = AudioPlayer();

  void choseAudio(ReaderModel reader) {
    this.reader = reader;
  }

  Future<void> setUrlAudio(Surah chapter) async {
    isFile = false;
    readerName = null;
    chapterName = null;
    this.chapter = chapter;
    this.chapter!.audioFile = reader;
    String id = chapter.number.toString().padLeft(3, '0');
    await audioPlayer.setUrl("${reader!.server}/$id.mp3");
    notifyListeners();
  }

  Future<void> setFileAudio(String path) async {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    String fileName =
    path.replaceFirst("${QuranData.downloadsDirPath}/", "");
    fileName = fileName.replaceFirst(".mp3", "");
    var [readerId, chapterId] = fileName.split("-");
    String readerName = isArabicLocale
        ? QuranData.audios[int.parse(readerId) - 1].reciter.ar
        : QuranData.audios[int.parse(readerId) - 1].reciter.en;
    String chapterName = isArabicLocale
        ? QuranData.quran[int.parse(chapterId) - 1].surahName.ar
        : QuranData
        .quran[int.parse(chapterId) - 1].surahName.en;
    filePath = path;
    this.readerName = readerName;
    this.chapterName = chapterName;
    isFile = true;
    await audioPlayer.setFilePath(filePath!);
    notifyListeners();
  }

  void playSwitch() {
    if (!audioPlayer.playing) {
      audioPlayer.play();
    } else {
      audioPlayer.pause();
    }
    notifyListeners();
  }

  void updateLoopMode() {
    if (audioPlayer.loopMode == LoopMode.off) {
      audioPlayer.setLoopMode(LoopMode.one);
    } else {
      audioPlayer.setLoopMode(LoopMode.off);
    }
    notifyListeners();
  }

  Future<void> playNext() async {
    if (isFile) {
      int currentIndex =
          QuranData.downloadedFiles.indexWhere((e) => e.path == filePath!);
      int nextIndex = (currentIndex + 1) % QuranData.downloadedFiles.length;
      await setFileAudio(QuranData.downloadedFiles[nextIndex].path);
    } else {
      int currentIndex =
          QuranData.quran.indexWhere((e) => e.number == chapter!.number);
      int nextIndex = (currentIndex + 1) % 114;
      chapter = QuranData.quran[nextIndex];
      notifyListeners();
      await setUrlAudio(chapter!);
    }
  }

  Future<void> playPreviuse() async {
    if (isFile) {
      int currentIndex =
      QuranData.downloadedFiles.indexWhere((e) => e.path == filePath!);
      int prevIndex = (currentIndex - 1);
      if(prevIndex != -1) {
        await setFileAudio(QuranData.downloadedFiles[prevIndex].path);
      }
    } else {
      int currentIndex =
          QuranData.quran.indexWhere((e) => e.number == chapter!.number);
      if (currentIndex > 0) {
        int prevIndex = (currentIndex - 1);
        if(prevIndex != -1) {
          chapter = QuranData.quran[prevIndex];
          notifyListeners();
          await setUrlAudio(chapter!);
        }
      }
    }
  }

  void closeControls() {
    chapter = null;
    readerName = null;
    chapterName = null;
    audioPlayer.pause();
    notifyListeners();
  }

  Future<void> downloadFiles() async {
    if (!await FileSystemEntity.isFile(
        "${await getDownloadDirectory()}/QuranDownloadedFiles/${chapter!.audioFile!.reciter.ar}-${chapter!.surahName.ar}.mp3")) {
      String id = chapter!.number.toString().padLeft(3, '0');
      await FileDownloader.downloadFile(
        url: "${chapter!.audioFile!.server}/$id.mp3",
        subPath: "QuranDownloadedFiles",
        downloadDestination: DownloadDestinations.publicDownloads,
        name: "${chapter!.audioFile!.id}-${chapter!.number}",
      );
      QuranData.getDownloadedFiles();
      notifyListeners();
    } else {
      // print("not downloaded");
    }
  }
}
