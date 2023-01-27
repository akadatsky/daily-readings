import 'package:flutter/material.dart';

import '../calendar.dart';
import '../settings/settings_screen.dart';
import 'goals_screen.dart';

class StatsScreen extends StatelessWidget {
  static String route = '/stats';

  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text('Stats'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    // backgroundColor: Colors.blueAccent, // <-- Button color
                    // foregroundColor: Colors.red, // <-- Splash color
                  ),
                  child:
                      const Icon(Icons.menu_book_outlined, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
