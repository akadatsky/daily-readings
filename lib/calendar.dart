import 'package:daily_readings/selected_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late SelectedDateProvider _selectedDateProvider;
  DateTime today = DateTime.now();
  String locale = "en_US";

  @override
  void initState() {
    _selectedDateProvider = context.read<SelectedDateProvider>();
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDateProvider.selectedDate = day;
    });
    Navigator.pop(context);
  }

  void _switchLanguage() {
    if (locale == "en_US") {
      setState(() {
        locale = "en_US";
      });
    } else if (locale == "es_ES") {
      setState(() {
        locale = "es_ES";
      });
    } else if (locale == "ru_RU") {
      setState(() {
        locale = "ru_RU";
      });
    } else if (locale == "uk_UA") {
      setState(() {
        locale = "uk_UA";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.calendar),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _switchLanguage,
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TableCalendar(
              locale: locale,
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) =>
                  isSameDay(day, _selectedDateProvider.selectedDate),
              focusedDay: _selectedDateProvider.selectedDate,
              firstDay: DateTime.utc(2010, 10, 11),
              lastDay: DateTime.utc(2100, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }
}
