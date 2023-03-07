import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef PageBuilder = Widget Function(DateTime date, bool isMorning);

class CalendarPagerController {
  DateTime selectedDate;

  CalendarPagerController(this.selectedDate);
}

class CalendarPager extends StatelessWidget {
  final CalendarPagerController controller;
  final PageBuilder builder;

  const CalendarPager({
    required this.controller,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 71, 123, 171),
          flexibleSpace: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wb_sunny),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.morning),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wb_twighlight),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.evening),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: CalendarPage(
          controller: controller,
          builder: builder,
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final CalendarPagerController controller;
  final PageBuilder builder;

  const CalendarPage({
    required this.controller,
    required this.builder,
    super.key,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const int maxInt = 0x7fffffff; // 32-bit
  final PageController _pageController = PageController(
    initialPage: maxInt ~/ 2,
  );
  var isMorning = true;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, position) {
        return widget.builder.call(
          widget.controller.selectedDate,
          isMorning,
        );
      },
    );
  }

  void _onPageChanged(int newPage) {
    isMorning = !isMorning;
    DefaultTabController.of(context)?.animateTo(isMorning ? 0 : 1);
    if (newPage > (_pageController.page ?? 0) && !isMorning) {
      widget.controller.selectedDate = widget.controller.selectedDate.add(
        const Duration(days: 1),
      );
    } else if (newPage < (_pageController.page ?? 0) && isMorning) {
      widget.controller.selectedDate = widget.controller.selectedDate.subtract(
        const Duration(days: 1),
      );
    }
  }
}
