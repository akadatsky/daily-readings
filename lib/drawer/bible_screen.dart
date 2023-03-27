import 'package:daily_readings/bible/bible.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../calendar.dart';
import '../settings/settings_screen.dart';
import '../ui/theme_provider.dart';
import 'goals_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bible/bible.dart' as Bible;
import 'package:sqflite/sqflite.dart';

class BibleScreen extends StatelessWidget {
  static String route = '/bible';

  const BibleScreen({Key? key}) : super(key: key);

  List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.bible),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GoalsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline)),
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings_rounded)),
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Calendar(),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month_sharp)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterListView(book: book),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

class ChapterListView extends StatelessWidget {
  final Book book;

  ChapterListView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: ListView.builder(
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          final chapter = book.chapters[index];
          return ListTile(
            title: Text('Chapter ${chapter.number}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerseListView(chapter: chapter),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VerseListView extends StatelessWidget {
  final Chapter chapter;

  VerseListView({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${chapter.book.name} ${chapter.number}'),
      ),
      body: ListView.builder(
        itemCount: chapter.verses.length,
        itemBuilder: (context, index) {
          final verse = chapter.verses[index];
          return ListTile(
            title: Text('${verse.number}: ${verse.text}'),
          );
        },
      ),
    );
  }
}
