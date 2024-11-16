import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/config/routes.dart';
import 'package:the_holy_quran/config/theme_notifier.dart';
import 'package:the_holy_quran/providers/audio_provider.dart';
import 'package:the_holy_quran/providers/locale_provider.dart';
import 'package:the_holy_quran/providers/quran_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_holy_quran/providers/quran_view_provider.dart';

// TODO :: add english language
// TODO :: add pages view
// TODO :: add voice reading
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => QuranViewProvider()),
        // ChangeNotifierProvider(create: (_) => QuranProvider()),
      ],
      child: Consumer2<ThemeNotifier, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeNotifier.lightTheme,
          themeMode: themeProvider.themeMode,
          darkTheme: ThemeNotifier.darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale("ar"), Locale("en")],
          locale: LocaleProvider.locale,
          initialRoute: Routes.initialRoute,
          routes: Routes.routes,
        ),
      ),
    );
  }
}

Future<void> initApp() async {
  await QuranData.initConstants();
  await LocaleProvider.getLocale();
  await QuranViewProvider.getQuranView();
}
