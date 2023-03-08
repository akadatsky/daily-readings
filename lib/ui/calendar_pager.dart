import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef PageBuilder = Widget Function(DateTime date, bool isMorning);
typedef PageListener = void Function(DateTime date);

class CalendarPagerController {
  DateTime selectedDate;

  CalendarPagerController(this.selectedDate);
}

class CalendarPager extends StatelessWidget {
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
          pageChangedListener: pageChangedListener,
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final CalendarPagerController controller;
  final PageBuilder builder;
  final PageListener pageChangedListener;

  const CalendarPage({
    required this.controller,
    required this.builder,
    required this.pageChangedListener,
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
  var currentPage = maxInt ~/ 2;

  bool isMorning = true;

  bool get isEvening => !isMorning;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (tabController.indexIsChanging) {
            // print('//===============================');
            // print(tabController.index);
            // print(tabController.previousIndex);
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
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
      DefaultTabController.of(context)?.animateTo(isMorning ? 0 : 1);
    });
  }
}
