import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  int fontSize = 28;
  ThemeMode themeMode = ThemeMode.system;

  late SharedPreferences sharedPreferences;
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFFEFCE7),
      elevation: 20,
    ),
    fontFamily: "HafsSmart",
    scaffoldBackgroundColor: const Color(0xFFFEFCE7),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFEFCE7),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF697565),
      elevation: 20,
    ),
    fontFamily: "HafsSmart",
    scaffoldBackgroundColor: const Color(0xFF1E201E),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF3C3D37),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    ),
  );

  ThemeNotifier() {
    getSettings();
  }

  Future<void> saveFontSize(BuildContext context) async {
    await sharedPreferences.setInt("fontSize", fontSize);
  }

  Future<void> getSettings() async {
    sharedPreferences = await SharedPreferences.getInstance();
    fontSize = sharedPreferences.getInt("fontSize") ?? fontSize;
    String themeModeString =
        sharedPreferences.getString("themeMode") ?? ThemeMode.system.toString();
    switch (themeModeString) {
      case "ThemeMode.dark":
        themeMode = ThemeMode.dark;
        break;
      case "ThemeMode.light":
        themeMode = ThemeMode.light;
        break;
      case "ThemeMode.system":
        themeMode = ThemeMode.system;
        break;
      default:
        throw ("ERROR unhandeled theme mode");
    }
    notifyListeners();
  }

  Future<void> updateFontSize(double fontSize) async {
    this.fontSize = fontSize.toInt();
    await sharedPreferences.setInt("fontSize", this.fontSize);
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? themeMode) async {
    this.themeMode = themeMode!;
    await sharedPreferences.setString("themeMode", themeMode.toString());
    notifyListeners();
  }
}
