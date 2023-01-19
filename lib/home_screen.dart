import 'dart:convert';
import 'package:daily_readings/bible_screen.dart';
import 'package:daily_readings/selected_date_provider.dart';
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
import 'stats_screen.dart';


enum Author { spurgeon, ryle }

class HomeScreen extends StatefulWidget {
  static String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Author? _author = Author.spurgeon;

  final databaseReference = FirebaseDatabase.instance.ref();
  late String morningDescription = '';
  late String eveningDescription = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDailyReadingFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text(DateFormat.yMMMMd().format(DateTime.now())),
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
                        onPressed: () {},
                        icon: const Icon(Icons.check_circle_outline)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings_rounded)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
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
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: RichText(
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            text:
                            '${morningDescription.isNotEmpty ? morningDescription : 'Focus on the Journey, Not the Outcome'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: RichText(
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            text:
                            '${eveningDescription.isNotEmpty ? eveningDescription : 'Focus on the Journey, Not the Outcome'}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                          ),
                        ),
                      ),
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
                                _author = value;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          const Divider(height: 0, color: Colors.grey),
                          RadioListTile<Author>(
                            title: const Text('J.C. Ryle'),
                            value: Author.ryle,
                            groupValue: _author,
                            onChanged: (Author? value) {
                              setState(() {
                                _author = value;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text('Home'),
                        leading: const Icon(Icons.home),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          Navigator.pushNamed(context,
                              HomeScreen.route); // Navigate to the home page
                        },
                      ),
                      ListTile(
                        title: const Text('Bible'),
                        leading: const Icon(Icons.book),
                        onTap: () {
                          Navigator.pop(context); // Close the drawer
                          Navigator.pushNamed(context,
                              BibleScreen.route); // Navigate to the home page
                        },
                      ),
                      ListTile(
                        title: const Text('Stats'),
                        leading: const Icon(Icons.stacked_bar_chart),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, StatsScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('Daily Goals'),
                        leading: const Icon(Icons.looks_one_sharp),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, GoalsScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('About'),
                        leading: const Icon(Icons.people_alt_rounded),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AboutScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('Feedback'),
                        leading: const Icon(Icons.format_quote),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, FeedbackScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('Copyright'),
                        leading: const Icon(Icons.copyright),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, CopyrightScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('Privacy'),
                        leading: const Icon(Icons.back_hand),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, PrivacyScreen.route);
                        },
                      ),
                      ListTile(
                        title: const Text('Help'),
                        leading: const Icon(Icons.question_mark),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, HelpScreen.route);
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
          }
          else {
            return const CircularProgressIndicator();
          }
        });
  }

  Future<DailyReading?> _getDailyReadingFromDatabase() async {
    String greetings = greeting();
    String today = DateFormat('dd.MM').format(DateTime.now());

    DataSnapshot snapshot = await databaseReference.get();
    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value));
      List<DailyReading> readings = List<DailyReading>.from(
          data.map((x) => DailyReading.fromJson(x as Map<String, dynamic>)));

      List<DailyReading> todaysReadings =
      readings.where((element) => element.date!.contains(today)).toList();
      morningDescription = todaysReadings
          .where((element) => element.time!.contains('Morning'))
          .first
          .description!;
      eveningDescription = todaysReadings
          .where((element) => element.time!.contains('Evening'))
          .first
          .description!;

      return todaysReadings
          .where((element) => element.date!.contains(today))
          .first;
    }
    return null;
  }


  Future getDailyReadingFromDatabase({DateTime? selectedDate}) async {
    if (selectedDate == null) {
      final selectedDateProvider = Provider.of<SelectedDateProvider>(context, listen: false);
      selectedDate = selectedDateProvider.selectedDate;
    }
    // handle the rest of the function here
  }
// ...


  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    return 'Evening';
  }
}