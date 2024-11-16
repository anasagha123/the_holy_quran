import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/config/responsive_font.dart';
import 'package:the_holy_quran/config/theme_notifier.dart';
import 'package:the_holy_quran/models/quran_view.dart';
import 'package:the_holy_quran/providers/locale_provider.dart';
import 'package:the_holy_quran/providers/quran_view_provider.dart';
import 'package:the_holy_quran/widgets/my_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/audio_controlls.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Selector<ThemeNotifier, int>(
          selector: (context, provider) => provider.fontSize,
          builder: (context, fontSize, child) => Text(
            AppLocalizations.of(context)!.settings,
            style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize.toDouble())),
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.fontSize,
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 24),
                  ),
                ),
                Selector<ThemeNotifier, int>(
                  selector: (context, provider) => provider.fontSize,
                  builder: (context, fontSize, child) => Slider(
                    max: 40,
                    min: 8,
                    inactiveColor: Colors.grey.shade600,
                    value: fontSize.toDouble(),
                    onChanged:
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .updateFontSize,
                  ),
                ),
                Selector<ThemeNotifier, int>(
                  selector: (context, provider) => provider.fontSize,
                  builder: (context, mushafFontSize, child) => Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${AppLocalizations.of(context)!.example} : ",
                          style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 24)),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.example_text,
                          style: TextStyle(
                            fontSize: mushafFontSize.toDouble(),
                            fontFamily: "me_quran",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  height: 100,
                  indent: 16,
                  endIndent: 16,
                ),
                Selector<ThemeNotifier, int>(
                  selector: (context, provider) => provider.fontSize,
                  builder: (context, fontSize, child) => Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Text(
                          AppLocalizations.of(context)!.theme,
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(
                                context, fontSize.toDouble()),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<ThemeMode>(
                          value:
                              Provider.of<ThemeNotifier>(context, listen: false)
                                  .themeMode,
                          items: [
                            DropdownMenuItem(
                              value: ThemeMode.system,
                              child: Text(AppLocalizations.of(context)!.system),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text(AppLocalizations.of(context)!.dark),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text(AppLocalizations.of(context)!.light),
                            ),
                          ],
                          onChanged:
                              Provider.of<ThemeNotifier>(context, listen: false)
                                  .updateThemeMode,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  height: 100,
                  indent: 16,
                  endIndent: 16,
                ),
                Selector<ThemeNotifier, int>(
                  selector: (context, provider) => provider.fontSize,
                  builder: (context, fontSize, child) => Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Text(
                          AppLocalizations.of(context)!.language,
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(
                                context, fontSize.toDouble()),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<Locale>(
                          value: LocaleProvider.locale,
                          items: [
                            DropdownMenuItem(
                              value: const Locale("ar"),
                              child: Text(AppLocalizations.of(context)!.arabic),
                            ),
                            DropdownMenuItem(
                              value: const Locale("en"),
                              child:
                                  Text(AppLocalizations.of(context)!.english),
                            ),
                          ],
                          onChanged: Provider.of<LocaleProvider>(context,
                                  listen: false)
                              .changeLocale,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  height: 100,
                  indent: 16,
                  endIndent: 16,
                ),
                Selector<ThemeNotifier, int>(
                  selector: (context, provider) => provider.fontSize,
                  builder: (context, fontSize, child) => Row(
                    children: [
                      const Spacer(),
                      // TODO ADD LOCALIZATION HERE
                      Expanded(
                        flex: 4,
                        child: Text(
                          AppLocalizations.of(context)!.display,
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(
                                context, fontSize.toDouble()),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: Consumer<QuranViewProvider>(
                          builder: (context, provider, child) => DropdownButtonFormField<QuranView>(
                            value: QuranViewProvider.quranView,
                            items:  [
                              DropdownMenuItem(
                                value: QuranView.complete,
                                child: Text(AppLocalizations.of(context)!.default_display),
                              ),
                              DropdownMenuItem(
                                value: QuranView.pages,
                                child: Text(AppLocalizations.of(context)!.pages_display),
                              ),
                            ],
                            onChanged: provider.setQuranView,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
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
