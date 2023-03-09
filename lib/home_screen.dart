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
class _HomeScreenContentState extends State<HomeScreenContent> {
  late Author? _author;
  late HashMap authorHashMap = HashMap<Author, String>();

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const AppBarDateLabel(),
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

                  return ReadingDescriptionScreen(
                    isMorning ? morningDescription : eveningDescription,
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
