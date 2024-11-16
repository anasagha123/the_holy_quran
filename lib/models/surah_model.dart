
import 'package:flutter/cupertino.dart';
import 'package:the_holy_quran/models/reader_model.dart';

class Surah {
  final int number;
  final SurahName surahName;
  final int versesCount;
  final int wordsCount;
  final int lettersCount;
  final List<Verse> verses;
  ReaderModel? audioFile;

  Surah({
    required this.number,
    required this.surahName,
    required this.versesCount,
    required this.wordsCount,
    required this.lettersCount,
    required this.verses,
    this.audioFile
  });

  factory Surah.fromMap(Map<String, dynamic> map) {
    List<Verse> verses =
        map["verses"].map<Verse>((e) => Verse.fromMap(e)).toList();
    return Surah(
      number: map["number"],
      surahName: SurahName.fromMap(map["name"]),
      versesCount: map["verses_count"],
      wordsCount: map["words__count"],
      lettersCount: map["letters__count"],
      verses: verses,
    );
  }
}

class SurahName {
  final String ar;
  final String en;
  final String transliteration;

  SurahName({
    required this.ar,
    required this.en,
    required this.transliteration,
  });

  factory SurahName.fromMap(Map<String, dynamic> map) => SurahName(
        ar: map["ar"],
        en: map["en"],
        transliteration: map["transliteration"],
      );
}

class RevelationPlace {
  final String ar;
  final String en;

  RevelationPlace({
    required this.ar,
    required this.en,
  });

  factory RevelationPlace.fromMap(Map<String, dynamic> map) => RevelationPlace(
        ar: map["ar"],
        en: map["en"],
      );
}

class Verse {
  final int number;
  final VerseText verseText;
  final int juz;
  final int page;
  final bool sajda;
  final GlobalKey key = GlobalKey();

  Verse({
    required this.number,
    required this.verseText,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory Verse.fromMap(Map<String, dynamic> map) {
    bool sajda;
    if (map["sajda"].runtimeType == bool) {
      sajda = map["sajda"];
    } else {
      sajda = map["sajda"]["recommended"];
    }
    return Verse(
      number: map["number"],
      verseText: VerseText.fromMap(map["text"]),
      juz: map["juz"],
      page: map["page"],
      sajda: sajda,
    );
  }
}

class VerseText {
  final String ar;

  final String en;

  VerseText({
    required this.ar,
    required this.en,
  });

  factory VerseText.fromMap(Map<String, dynamic> map) => VerseText(
        ar: map["ar"],
        en: map["en"],
      );
}
