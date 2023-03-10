import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../calendar.dart';
import '../settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/theme_provider.dart';

class GoalsScreen extends StatelessWidget {
  static String route = '/goals';

  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.daily_goals),
          centerTitle: false,
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
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60, bottom: 10, left: 10, right: 10),
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('SET',
                                  style: TextStyle(
                                    color: themeProvider.isDarkModeEnabled
                                        ? Colors.white
                                        : Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60, bottom: 10, left: 10, right: 10),
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('CANCEL',
                                  style: TextStyle(
                                    color: themeProvider.isDarkModeEnabled
                                        ? Colors.white
                                        : Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: const TextSpan(
                    text: '\nNOT STARTED',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
