import 'dart:collection';
import 'dart:convert';
import 'package:daily_readings/bible_screen.dart';
import 'package:daily_readings/selected_date_provider.dart';
import 'package:daily_readings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'about_screen.dart';
import 'calendar.dart';
import 'copyright_screen.dart';
import 'daily_reading.model.dart';
import 'feedback_screen.dart';
import 'goals_screen.dart';
import 'help_screen.dart';
import 'privacy_screen.dart';
import 'reading_description_screen.dart';
import 'stats_screen.dart';

enum Author { spurgeon, ryle }

class HomeScreen extends StatefulWidget {
  static String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//-----------------------------------------------------------------
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Author? _author;
  late HashMap authorHashMap = HashMap<Author, String>();

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    _author = Author.spurgeon;
    final data = <Author, String>{
      Author.spurgeon: 'Spurgeon',
      Author.ryle: 'Ryle'
    };
    authorHashMap.addEntries(data.entries);

    super.initState();
  }

//-----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedDateProvider>(
      builder: (_, provider, child) {
        DateTime? selectedDate = provider.selectedDate;
        return FutureBuilder<List<DailyReading?>>(
          future: getDailyReadingFromDatabase(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<DailyReading?>? todaysReadings = snapshot.data;
                if (todaysReadings!.isEmpty) {
                  return const Text('No reading');
                }
                String? morningDescription = todaysReadings
                    .where((element) => element!.time!.contains('Morning'))
                    .first
                    ?.description;
                String? eveningDescription = todaysReadings
                    .where((element) => element!.time!.contains('Evening'))
                    .first
                    ?.description;

                return DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                            '${DateFormat.yMMMMd().format(DateTime.now())} ${selectedDate.day != DateTime.now().day ? '(${DateFormat.yMMMMd().format(selectedDate)})' : ''}'),
                      ),
                      backgroundColor: const Color.fromARGB(255, 71, 123, 171),
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.wb_sunny),
                                SizedBox(width: 8),
                                Text('Morning'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.wb_twighlight),
                                SizedBox(width: 8),
                                Text('Evening'),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                              ).then((value) => {setState(() {})});
                            },
                            icon: const Icon(Icons.calendar_month_sharp)),
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TabBarView(
                        children: [
                          ReadingDescriptionScreen(morningDescription),
                          ReadingDescriptionScreen(eveningDescription),
                        ],
                      ),
                    ),
                    drawer: Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage('assets/bookcover.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Text(''),
                          ),
                          const ListTile(
                            title: Text('Daily Readings Selection'),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadioListTile<Author>(
                                title: const Text('Spurgeon'),
                                value: Author.spurgeon,
                                groupValue: _author,
                                onChanged: (Author? value) {
                                  setState(() {
                                    _author = value!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                              const Divider(height: 0, color: Colors.grey),
                              RadioListTile<Author>(
                                title: const Text('J.C. Ryle'),
                                value: Author.ryle,
                                groupValue: _author,
                                onChanged: (Author? value) {
                                  setState(() {
                                    _author = value!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ],
                          ),
                          ListTile(
                            title: const Text('Home'),
                            leading: const Icon(Icons.home),
                            onTap: () async {
                              Navigator.pop(context); // Close the drawer
                              await Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.route,
                                //  / (slaş) olarak belirtilen
                                //  sayfaya kadar gezilmiş önceki sayfaların tamamını sil
                                ModalRoute.withName('/'),
                              ).then((value) => {setState(() {})});
                            },
                          ),
                          ListTile(
                            title: const Text('Bible'),
                            leading: const Icon(Icons.book),
                            onTap: () async {
                              Navigator.pop(context); // Close the drawer
                              await Navigator.pushNamed(
                                  context,
                                  BibleScreen
                                      .route); // Navigate to the home page
                            },
                          ),
                          ListTile(
                            title: const Text('Stats'),
                            leading: const Icon(Icons.stacked_bar_chart),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, StatsScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('Daily Goals'),
                            leading: const Icon(Icons.looks_one_sharp),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, GoalsScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('About'),
                            leading: const Icon(Icons.people_alt_rounded),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, AboutScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('Feedback'),
                            leading: const Icon(Icons.format_quote),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, FeedbackScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('Copyright'),
                            leading: const Icon(Icons.copyright),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, CopyrightScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('Privacy'),
                            leading: const Icon(Icons.back_hand),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, PrivacyScreen.route);
                            },
                          ),
                          ListTile(
                            title: const Text('Help'),
                            leading: const Icon(Icons.question_mark),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                  context, HelpScreen.route);
                            },
                          ),
                          const Text("App version: X.X.X",
                              textAlign: TextAlign.center),
                          const Text("Content version: XXX",
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('Error getting data');
              } else {
                return const Text('No reading for today');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

//-----------------------------------------------------------------
  Future<List<DailyReading?>> getDailyReadingFromDatabase(
      DateTime? selectedDate) async {
    selectedDate ??= DateTime.now();

    String formattedDate = DateFormat('dd.MM').format(selectedDate);

    DataSnapshot snapshot = await databaseReference.get();
    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value));
      List<DailyReading> readings = List<DailyReading>.from(
          data.map((x) => DailyReading.fromJson(x as Map<String, dynamic>)));

      List<DailyReading> todaysReadings = readings
          .where((element) => element.date!.contains(formattedDate))
          .where((element) => _author != null
              ? element.author!.contains(authorHashMap[_author])
              : true)
          .toList();

      return todaysReadings;
    }
    return List.empty();
  }
//-----------------------------------------------------------------
}
