import 'package:daily_readings/selected_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late SelectedDateProvider _selectedDateProvider;
  DateTime today = DateTime.now();

  @override
  void initState() {
    _selectedDateProvider = context.read<SelectedDateProvider>();
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    _selectedDateProvider.selectedDate = day;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectedDayScreen(day: today),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Text("Selected Day = ${today.toString().split(" ")[0]}"),
            TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
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

class SelectedDayScreen extends StatelessWidget {
  final DateTime day;
  const SelectedDayScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Day"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Selected Day: ${day.toString().split(" ")[0]}"),
      ),
    );
  }
}
