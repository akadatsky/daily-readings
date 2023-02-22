import 'package:daily_readings/selected_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
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
  String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDateProvider.selectedDate,
      firstDate: DateTime.utc(1900, 10, 11),
      lastDate: DateTime.utc(2150, 3, 14),
      dateFormat: "dd-MMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    if (picked != null) {
      setState(() {
        _selectedDateProvider.selectedDate = picked;
        formattedDate = DateFormat.yMMMd().format(picked);
      });
    }
  }

  @override
  void initState() {
    _selectedDateProvider = context.read<SelectedDateProvider>();
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDateProvider.selectedDate = day;
      formattedDate = DateFormat.yMMMd().format(day);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.calendar),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.insert_invitation),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TableCalendar(
              locale: Localizations.localeOf(context).toString(),
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) =>
                  isSameDay(day, _selectedDateProvider.selectedDate),
              focusedDay: _selectedDateProvider.selectedDate,
              firstDay: DateTime.utc(1900, 10, 11),
              lastDay: DateTime.utc(2150, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }
}
