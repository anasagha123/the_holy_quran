import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:the_holy_quran/models/quran_view.dart';
import 'package:the_holy_quran/providers/locale_provider.dart';
import 'package:the_holy_quran/providers/quran_data.dart';
import 'package:the_holy_quran/providers/quran_view_provider.dart';
import 'package:the_holy_quran/widgets/my_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_holy_quran/widgets/page_builder.dart';

import '../widgets/audio_controlls.dart';
import '../widgets/dropdown_textfield/dropdown_textfield.dart';
import '../widgets/surah_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _itemScrollController = ItemScrollController();
  final _pageController = PageController();
  int _currentIndex = 0;

  void _scrollToChapter(dynamic surah) async {
    int index =
        QuranData.quran.indexWhere((e) => e.surahName.ar == surah.value);
    switch (QuranViewProvider.quranView) {
      case QuranView.complete:
        await _itemScrollController.scrollTo(
          index: index,
          duration: Durations.extralong4,
          curve: Curves.easeInOutCubic,
        );
        break;
      case QuranView.pages:
        int page = QuranData.quran[index].verses[0].page - 1;
        await _pageController.animateToPage(
          page,
          duration: Durations.extralong4,
          curve: Curves.easeInOutCubic,
        );
    }
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        actions: (QuranViewProvider.quranView == QuranView.pages)
            ? [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green),
                  child: Text((_currentIndex + 1).toString()),
                )
              ]
            : null,
        title: DropDownTextField(
          textFieldDecoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            prefixIcon: const Icon(Icons.search),
          ),
          searchTextStyle: const TextStyle(color: Colors.black),
          listTextStyle: const TextStyle(color: Colors.black),
          dropDownItemCount: 5,
          enableSearch: true,
          searchAutofocus: true,
          onChanged: _scrollToChapter,
          searchDecoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.surah_name),
          dropDownList: QuranData.quran
              .map((e) => DropDownValueModel(
                  name: isArabicLocale ? e.surahName.ar : e.surahName.en,
                  value: e.surahName.ar))
              .toList(),
        ),
      ),
      body: Stack(
        children: [
          QuranViewProvider.quranView == QuranView.complete
              ? ScrollablePositionedList.builder(
                  physics: const BouncingScrollPhysics(),
                  itemScrollController: _itemScrollController,
                  itemCount: QuranData.quran.length,
                  itemBuilder: (context, index) {
                    return SurahWidget(QuranData.quran[index]);
                  },
                )
              : PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: onPageChanged,
                  itemCount: 604,
                  itemBuilder: (context, index) => PageBuilder(index + 1),
                ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AudioControls(),
          ),
        ],
      ),
      floatingActionButton: (QuranViewProvider.quranView == QuranView.complete)
          ? FloatingActionButton(
              mini: true,
              onPressed: () async {
                await _itemScrollController.scrollTo(
                  index: 0,
                  duration: Durations.extralong4,
                  curve: Curves.easeInOutCubic,
                );
              },
              child: const Icon(Icons.keyboard_arrow_up_outlined),
            )
          : null,
    );
  }
}
