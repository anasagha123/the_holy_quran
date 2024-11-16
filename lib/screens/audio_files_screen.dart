
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/models/reader_model.dart';
import 'package:the_holy_quran/providers/audio_provider.dart';
import 'package:the_holy_quran/providers/quran_data.dart';
import 'package:the_holy_quran/screens/chose_chapter_screen.dart';
import 'package:the_holy_quran/widgets/audio_bottomsheet.dart';
import 'package:the_holy_quran/widgets/my_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/locale_provider.dart';
import '../widgets/audio_controlls.dart';

class AudioFilesScreen extends StatefulWidget {
  static const routeName = "/audio_files";

  const AudioFilesScreen({super.key});

  @override
  State<AudioFilesScreen> createState() => _AudioFilesScreenState();
}

class _AudioFilesScreenState extends State<AudioFilesScreen> {
  List<ReaderModel> _audios = QuranData.audios;
  final _reciterNameController = TextEditingController();
  final _pageController = PageController();
  int currentIndex = 0;
  bool isArabicLocale = LocaleProvider.locale.languageCode == "ar";

  void search(String? val) {
    setState(() {
      if (currentIndex == 0) {
        if (isArabicLocale) {
          _audios = QuranData.audios
              .where((e) => e.reciter.ar.contains(val!))
              .toList();
        } else {
          _audios = QuranData.audios
              .where((e) =>
                  e.reciter.en.toUpperCase().contains(val!.toUpperCase()))
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _reciterNameController,
          onChanged: search,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: AppLocalizations.of(context)!.reader_name,
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
            children: [
              ListView.builder(
                itemCount: _audios.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Provider.of<AudioProvider>(context, listen: false)
                        .choseAudio(_audios[index]);
                    Navigator.pushNamed(context, ChoseChapterScreen.routeName);
                  },
                  leading: Text("${index + 1}"),
                  title: Text(
                    isArabicLocale
                        ? _audios[index].reciter.ar
                        : _audios[index].reciter.en,
                  ),
                ),
              ),
              Consumer<AudioProvider>(
                builder: (context, provider, child) => ListView.builder(
                  itemCount: QuranData.downloadedFiles.length,
                  itemBuilder: (context, index) {
                    String path = QuranData.downloadedFiles[index].path;
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
                    return ListTile(
                      onTap: () {
                        Provider.of<AudioProvider>(context, listen: false)
                            .setFileAudio(path);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const AudioBottomSheet(),
                        );
                      },
                      leading: Text("${index + 1}"),
                      title: Text("$readerName - $chapterName"),
                    );
                  },
                ),
              ),
            ],
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AudioControls(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _pageController.animateToPage(
          index,
          duration: Durations.medium2,
          curve: Curves.easeInCubic,
        ),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.readers,
            icon: const Icon(Icons.audiotrack_outlined),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.downloads,
            icon: const Icon(Icons.file_download_outlined),
          ),
        ],
      ),
    );
  }
}
