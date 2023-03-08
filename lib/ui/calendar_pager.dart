import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef PageBuilder = Widget Function(DateTime date, bool isMorning);
typedef PageListener = void Function(DateTime date);

class CalendarPagerController {
  DateTime selectedDate;

  CalendarPagerController(this.selectedDate);
}

class CalendarPager extends StatefulWidget {
  final CalendarPagerController controller;
  final PageBuilder builder;
  final PageListener pageChangedListener;

  const CalendarPager({
    required this.controller,
    required this.builder,
    required this.pageChangedListener,
    super.key,
  });

  @override
  State<CalendarPager> createState() => _CalendarPagerState();
}

class _CalendarPagerState extends State<CalendarPager>
    with TickerProviderStateMixin {
  static const int maxInt = 0x7fffffff; // 32-bit
  final PageController _pageController = PageController(
    initialPage: maxInt ~/ 2,
  );
  var currentPage = maxInt ~/ 2;

  late TabController tabController;

  bool isMorning = true;

  bool get isEvening => !isMorning;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 71, 123, 171),
        flexibleSpace: TabBar(
          controller: tabController,
          onTap: (page) {
            if (page == 0 && isEvening) {
              _pageController.jumpToPage(currentPage - 1);
            }
            if (page == 1 && isMorning) {
              _pageController.jumpToPage(currentPage + 1);
            }
          },
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
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, position) {
          var nextDate = widget.controller.selectedDate;
          if (position > currentPage && isEvening) {
            nextDate = nextDate.add(const Duration(days: 1));
          }
          if (position > currentPage && isMorning) {
            nextDate = nextDate.subtract(const Duration(days: 1));
          }
          return widget.builder.call(
            widget.controller.selectedDate,
            isMorning,
          );
        },
      ),
    );
  }

  void _onPageChanged(int newPage) {
    if (newPage > (_pageController.page ?? 0) && isEvening) {
      widget.controller.selectedDate = widget.controller.selectedDate.add(
        const Duration(days: 1),
      );
    } else if (newPage < (_pageController.page ?? 0) && isMorning) {
      widget.controller.selectedDate = widget.controller.selectedDate.subtract(
        const Duration(days: 1),
      );
    }
    isMorning = !isMorning;
    widget.pageChangedListener.call(widget.controller.selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabController.animateTo(isMorning ? 0 : 1);
    });
  }
}