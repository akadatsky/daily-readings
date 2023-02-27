import 'dart:collection';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reading_description_screen.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/home';

  const HomeScreen(this.setLocale, {Key? key}) : super(key: key);

  final void Function(Locale locale) setLocale;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//-----------------------------------------------------------------
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Author? _author;
  late HashMap authorHashMap = HashMap<Author, String>();

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final String cacheKey = 'dailyReadings';

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
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                String dateFormat;
                if (width < 200) {
                  dateFormat = DateFormat.yMMMd(
                          Localizations.localeOf(context).languageCode)
                      .format(selectedDate);
                } else {
                  dateFormat = DateFormat.yMMMMd(
                          Localizations.localeOf(context).languageCode)
                      .format(selectedDate);
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(dateFormat),
                );
              },
            ),
            backgroundColor: const Color.fromARGB(255, 71, 123, 171),
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
          drawer: DrawerScreen(
              author: _author,
              onAuthorChanged: (value) {
                setState(() {
                  _author = value;
                });
              }),
          body: FutureBuilder<List<DailyReading?>>(
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
                    child: PageView(
                      children: [
                        Scaffold(
                          appBar: AppBar(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 71, 123, 171),
                            flexibleSpace: TabBar(
                              labelColor: Colors.white,
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.wb_sunny),
                                      const SizedBox(width: 8),
                                      Text(AppLocalizations.of(context)!
                                          .morning),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.wb_twighlight),
                                      const SizedBox(width: 8),
                                      Text(AppLocalizations.of(context)!
                                          .evening),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                        ),
                      ],
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
          ),
        );
      },
    );
  }

//-----------------------------------------------------------------
  Future<List<DailyReading?>> getDailyReadingFromDatabase(
      DateTime? selectedDate) async {
    selectedDate ??= DateTime.now();
    String formattedDate = DateFormat('dd.MM').format(selectedDate);

    // Check if the data is already saved in the cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      final data = jsonDecode(cachedData);
      List<DailyReading> readings = List<DailyReading>.from(
        data.map((x) => DailyReading.fromJson(x as Map<String, dynamic>)),
      );

      List<DailyReading> todaysReadings = readings
          .where((element) => element.date!.contains(formattedDate))
          .where((element) => _author != null
              ? element.author!.contains(authorHashMap[_author])
              : true)
          .toList();

      return todaysReadings;
    } else {
      // If the data is not in the cache, fetch it from the database
      DataSnapshot snapshot = await databaseReference.get();
      if (snapshot.exists) {
        final data = jsonDecode(jsonEncode(snapshot.value));
        List<DailyReading> readings = List<DailyReading>.from(
          data.map((x) => DailyReading.fromJson(x as Map<String, dynamic>)),
        );

        List<DailyReading> todaysReadings = readings
            .where((element) => element.date!.contains(formattedDate))
            .where((element) => _author != null
                ? element.author!.contains(authorHashMap[_author])
                : true)
            .toList();

        // Save the data in the cache
        await prefs.setString(cacheKey, jsonEncode(data));

        return todaysReadings;
      }
    }
    return List.empty();
  }
//-----------------------------------------------------------------
}
