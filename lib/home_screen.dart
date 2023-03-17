import 'dart:collection';
import 'dart:convert';
import 'package:daily_readings/ui/calendar_pager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  static String route = '/home';

  const HomeScreen(this.setLocale, {Key? key}) : super(key: key);

  final void Function(Locale locale) setLocale;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedDateProvider>(
      builder: (_, provider, child) {
        return ChangeNotifierProvider(
          create: (_) => DateCounter(),
          child: Builder(
            builder: (context) {
              Future.delayed(const Duration(milliseconds: 100), () {
                context.read<DateCounter>().update(provider.selectedDate);
              });
              return HomeScreenContent(
                setLocale: setLocale,
                selectedDate: provider.selectedDate,
              );
            },
          ),
        );
      },
    );
  }
}

class DateCounter with ChangeNotifier {
  DateTime _count = DateTime.now();

  DateTime get count => _count;

  void update(DateTime value) {
    _count = value;
    notifyListeners();
  }
}

class HomeScreenContent extends StatefulWidget {
  final void Function(Locale locale) setLocale;
  final DateTime selectedDate;

  const HomeScreenContent({
    Key? key,
    required this.setLocale,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

//-----------------------------------------------------------------
class _HomeScreenContentState extends State<HomeScreenContent>
    with TickerProviderStateMixin {
  late Author? _author;
  late HashMap authorHashMap = HashMap<Author, String>();

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final String cacheKey = 'dailyReadings';

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

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
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const AppBarDateLabel(),
          // backgroundColor: const Color.fromARGB(255, 71, 123, 171),
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
        body: CalendarPager(
          controller: CalendarPagerController(widget.selectedDate),
          pageChangedListener: (date) {
            Future.delayed(const Duration(milliseconds: 100), () {
              context.read<DateCounter>().update(date);
            });
          },
          builder: (date, isMorning) {
            return FutureBuilder<List<DailyReading?>>(
              future: getDailyReadingFromDatabase(date),
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

                    var now = DateTime.now();
                    var month = now.month;
                    var image;

                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          if (morningDescription != null) {
                            if (month == 1) {
                              Image(
                                image: const AssetImage('assets/Morning/Jan.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 2) {
                              Image(
                                image: const AssetImage('assets/Morning/Feb.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 3) {
                              Image(
                                image: const AssetImage('assets/Morning/March.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 4) {
                              Image(
                                image: const AssetImage('assets/Morning/April.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 5) {
                              Image(
                                image: const AssetImage('assets/Morning/May.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 6) {
                              Image(
                                image: const AssetImage('assets/Morning/June.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 7) {
                              Image(
                                image: const AssetImage('assets/Morning/July.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 8) {
                              Image(
                                image: const AssetImage('assets/Morning/Aug.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 9) {
                              Image(
                                image: const AssetImage('assets/Morning/Sept.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 10) {
                              Image(
                                image: const AssetImage('assets/Morning/Oct.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 11) {
                              Image(
                                image: const AssetImage('assets/Morning/Nov.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else {
                              Image(
                                image: const AssetImage('assets/Morning/Dec.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            }
                          } else {
                            if (month == 1) {
                              Image(
                                image: const AssetImage('assets/Evening/Jan.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 2) {
                              Image(
                                image: const AssetImage('assets/Evening/Feb.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 3) {
                              Image(
                                image: const AssetImage('assets/Evening/March.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 4) {
                              Image(
                                image: const AssetImage('assets/Evening/April.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 5) {
                              Image(
                                image: const AssetImage('assets/Evening/May.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 6) {
                              Image(
                                image: const AssetImage('assets/Evening/June.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 7) {
                              Image(
                                image: const AssetImage('assets/Evening/July.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 8) {
                              Image(
                                image: const AssetImage('assets/Evening/Aug.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 9) {
                              Image(
                                image: const AssetImage('assets/Evening/Sept.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 10) {
                              Image(
                                image: const AssetImage('assets/Evening/Oct.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else if (month == 11) {
                              Image(
                                image: const AssetImage('assets/Evening/Nov.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            } else {
                              Image(
                                image: const AssetImage('assets/Evening/Dec.jpg'),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.37,
                                fit: BoxFit.fill,
                              ),
                            }
                          }
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        '’Let anyone who thinks that he stands take heed lest he fall’',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          backgroundColor: Colors.black45,
                                        ),
                                        softWrap: true,
                                        maxLines: 4,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          '1 Corinthians 10:12',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            backgroundColor: Colors.black45,
                                          ),
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 18, top:  MediaQuery.of(context).size.height * 0.375, right: 18, bottom: 1),
                            //EdgeInsets.fromLTRB(18, 303, 18, 1),
                            child: ReadingDescriptionScreen(
                              isMorning ? morningDescription : eveningDescription,
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
            );
          },
        ),
      );
    });
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

class AppBarDateLabel extends StatelessWidget {
  const AppBarDateLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final dateToDisplay = context.watch<DateCounter>().count;
        String dateFormat;
        if (width < 200) {
          dateFormat =
              DateFormat.yMMMd(Localizations.localeOf(context).languageCode)
                  .format(dateToDisplay);
        } else {
          dateFormat =
              DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
                  .format(dateToDisplay);
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(dateFormat),
        );
      },
    );
  }
}