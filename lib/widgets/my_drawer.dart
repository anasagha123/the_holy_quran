import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/config/responsive_font.dart';
import 'package:the_holy_quran/screens/about_us_screen.dart';
import 'package:the_holy_quran/screens/audio_files_screen.dart';
import 'package:the_holy_quran/screens/home_screen.dart';
import 'package:the_holy_quran/screens/settings_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config/theme_notifier.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Image.asset("assets/images/quran.png")),
          const Divider(
            height: 32,
            color: Colors.black,
            endIndent: 16,
            indent: 16,
          ),
          ListTile(
            selected:
                ModalRoute.settingsOf(context)!.name == HomeScreen.routeName,
            selectedColor: Colors.white,
            selectedTileColor: Colors.green.withAlpha(160),
            leading: const Icon(Icons.home_outlined),
            title: Text(
              AppLocalizations.of(context)!.home,
              style: TextStyle(
                fontSize: getResponsiveFontSize(
                    context,
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .fontSize
                        .toDouble()),
              ),
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName),
          ),
          ListTile(
            selected: ModalRoute.settingsOf(context)!.name ==
                SettingsScreen.routeName,
            selectedColor: Colors.white,
            selectedTileColor: Colors.green.withAlpha(160),
            leading: const Icon(Icons.settings_outlined),
            title: Text(
              AppLocalizations.of(context)!.settings,
              style: TextStyle(
                fontSize: getResponsiveFontSize(
                    context,
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .fontSize
                        .toDouble()),
              ),
            ),
            onTap: () => Navigator.pushReplacementNamed(
                context, SettingsScreen.routeName),
          ),
          ListTile(
            selected: ModalRoute.settingsOf(context)!.name ==
                AudioFilesScreen.routeName,
            selectedColor: Colors.white,
            selectedTileColor: Colors.green.withAlpha(160),
            leading: const Icon(Icons.audiotrack_outlined),
            title: Text(
              AppLocalizations.of(context)!.audio_files,
              style: TextStyle(
                fontSize: getResponsiveFontSize(
                    context,
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .fontSize
                        .toDouble()),
              ),
            ),
            onTap: () => Navigator.pushReplacementNamed(
                context, AudioFilesScreen.routeName),
          ),
          ListTile(
            selected:
                ModalRoute.settingsOf(context)!.name == AboutUsScreen.routeName,
            selectedColor: Colors.white,
            selectedTileColor: Colors.green.withAlpha(160),
            leading: const Icon(Icons.info_outline),
            title: Text(
              AppLocalizations.of(context)!.about_us,
              style: TextStyle(
                fontSize: getResponsiveFontSize(
                    context,
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .fontSize
                        .toDouble()),
              ),
            ),
            onTap: () => Navigator.pushReplacementNamed(
                context, AboutUsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
