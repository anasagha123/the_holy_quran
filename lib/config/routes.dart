import 'package:flutter/material.dart';
import 'package:the_holy_quran/screens/about_us_screen.dart';
import 'package:the_holy_quran/screens/audio_files_screen.dart';
import 'package:the_holy_quran/screens/chose_chapter_screen.dart';
import 'package:the_holy_quran/screens/home_screen.dart';
import 'package:the_holy_quran/screens/settings_screen.dart';

class Routes {
  static String initialRoute = HomeScreen.routeName;

  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (context) => const HomeScreen(),
    SettingsScreen.routeName: (context) => const SettingsScreen(),
    AudioFilesScreen.routeName: (context) => const AudioFilesScreen(),
    ChoseChapterScreen.routeName: (context) => const ChoseChapterScreen(),
    AboutUsScreen.routeName: (context) => const AboutUsScreen(),
  };
}
