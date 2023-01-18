import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'bible_screen.dart';
import 'copyright_screen.dart';
import 'feedback_screen.dart';
import 'firebase_options.dart';
import 'goals_screen.dart';
import 'help_screen.dart';
import 'home_screen.dart';
import 'privacy_screen.dart';
import 'stats_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: "Daily Readings", options: dailyReadindDatabaseOption);
  runApp(const MyApp());
}

final ThemeData theme = ThemeData();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
}
