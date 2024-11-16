import 'dart:convert';
import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/services.dart';
import 'package:the_holy_quran/models/reader_model.dart';

import '../models/surah_model.dart';

class QuranData {
  static List<Surah> quran = [];
  static List<ReaderModel> audios = [];
  static List<FileSystemEntity> downloadedFiles = [];
  static late String downloadsDirPath;

  static Future<dynamic> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  static Future<void> initConstants() async {
    List<dynamic> surahs = await loadJsonFromAssets("assets/data/quran.json");
    await getDownloadedFiles();
    for( var jsonData in surahs){
      quran.add(Surah.fromMap(jsonData));
    }
    for( var jsonData in surahs[0]["audio"]){
      audios.add(ReaderModel.fromJson(jsonData));
    }
  }

  static Future<void> getDownloadedFiles() async {
    downloadsDirPath = "${(await getDownloadDirectory()).path}/QuranDownloadedFiles";
    Directory downloadsDir = Directory(downloadsDirPath);
    if(!downloadsDir.existsSync()){
      downloadsDir.createSync();
    }
    downloadedFiles = downloadsDir.listSync(followLinks: false);
  }
}
