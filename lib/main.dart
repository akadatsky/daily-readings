import 'package:daily_readings/selected_date_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer/about_screen.dart';
import 'drawer/bible_screen.dart';
import 'drawer/copyright_screen.dart';
import 'drawer/feedback_screen.dart';
import 'drawer/goals_screen.dart';
import 'drawer/stats_screen.dart';
import 'firebase_options.dart';
import 'drawer/help_screen.dart';
import 'home_screen.dart';
import 'drawer/privacy_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: "Daily Readings", options: dailyReadindDatabaseOption);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<SelectedDateProvider>(
          create: (context) => SelectedDateProvider()),
    ], child: const MyApp()),
  );
}

final ThemeData theme = ThemeData();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Daily Readings',
        routes: {
          HomeScreen.route: (context) => const HomeScreen(),
          BibleScreen.route: (context) => const BibleScreen(),
          StatsScreen.route: (context) => const StatsScreen(),
          GoalsScreen.route: (context) => const GoalsScreen(),
          AboutScreen.route: (context) => const AboutScreen(),
          FeedbackScreen.route: (context) => const FeedbackScreen(),
          CopyrightScreen.route: (context) => const CopyrightScreen(),
          PrivacyScreen.route: (context) => const PrivacyScreen(),
          HelpScreen.route: (context) => const HelpScreen(),
        },
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color(0xff477bab),
          ),
        ),
        initialRoute: HomeScreen.route,
        debugShowCheckedModeBanner: false,
      );
}
