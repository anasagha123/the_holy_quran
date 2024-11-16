import 'package:flutter/material.dart';
import 'package:the_holy_quran/widgets/audio_controlls.dart';
import 'package:the_holy_quran/widgets/my_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = "/about-us";

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about_us),
        centerTitle: true,
      ),
      body: const Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AudioControls(),
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
