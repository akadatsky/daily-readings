import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
§import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  static String route = '/bible';

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  String _selectedBook = 'Genesis';
  String _selectedChapter = '1';
  final List<String> _books = [];
  final List<String> _chapters = [];
  String _bibleText = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBibleData();
  }

  Future<void> _loadBibleData() async {
    // Downloading the Bible XML file from assets
    final xmlString = await rootBundle.loadString('assets/bible/ESV.xml');
    final document = XmlDocument.parse(xmlString);
    final books = document.findAllElements('BIBLEBOOK');

    // Getting a list of Bible book titles and a chapter list of the selected Bible book
    for (final book in books) {
      _books.add(book.getAttribute('bname')!);
    }
    final genesis = books.firstWhere((book) {
      return book.getAttribute('bname') == 'Genesis';
    });
    final chapters = genesis.findElements('CHAPTER');
    for (final chapter in chapters) {
      _chapters.add(chapter.getAttribute('cnumber')!);
    }

    // Getting the text from the Bible
    final selectedBookElement = books.firstWhere((book) {
      return book.getAttribute('bname') == _selectedBook;
    });
    final selectedChapterElement =
        selectedBookElement.findElements('CHAPTER').firstWhere((chapter) {
      return chapter.getAttribute('cnumber') == _selectedChapter;
    });
    final verses = selectedChapterElement.findElements('VERS');
    for (final verse in verses) {
      _bibleText += verse.text + ' ';
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedBook,
                    items: _books.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBook = value!;
                        _selectedChapter = _chapters.first;
                        _bibleText = '';
                        _loadBibleData();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedChapter,
                    items:
                        _chapters.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedChapter = value!;
                        _bibleText = '';
                        _loadBibleData();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _bibleText,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

//
// class BibleScreen extends StatefulWidget {
//
//   static String route = '/bible';
//
//   const BibleScreen({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(AppLocalizations.of(context)!.bible),
//           centerTitle: false,
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const GoalsScreen(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.check_circle_outline)),
//             IconButton(
//                 onPressed: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SettingsScreen(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.settings_rounded)),
//             IconButton(
//                 onPressed: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const Calendar(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.calendar_month_sharp)),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SingleChildScrollView(
//             child: Center(
//
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
