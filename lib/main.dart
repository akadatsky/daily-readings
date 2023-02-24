import 'package:daily_readings/selected_date_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'l10n/setting_provider.dart';
import 'l10n/shared_pref.dart';
import 'login/register_screen.dart';
import 'package:intl/intl.dart';


Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: "Daily Readings", options: dailyReadindDatabaseOption);
  await SharedPref.getLang();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<SelectedDateProvider>(
          create: (context) => SelectedDateProvider()),
      ChangeNotifierProvider(create: (context) => SettingProvider()),
    ], child: const MyApp()),
  );
}

final ThemeData theme = ThemeData();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;


  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
        title: 'Daily Readings',
        routes: {
          HomeScreen.route: (context) => HomeScreen(setLocale),
          RegisterScreen.route: (context) => const RegisterScreen(),
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

        // theme: themeProvider.darkMode
        //     ? ThemeData.dark().copyWith(
        //   colorScheme: const ColorScheme.dark(primary: Color(0xff477bab)),
        // )
        //     : ThemeData.dark().copyWith(
        //   colorScheme: const ColorScheme.light(primary: Color(0xff040405)),
        // ),


        // home: const RegisterScreen(),
        initialRoute: HomeScreen.route,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(Provider
            .of<SettingProvider>(context)
            .local ??
            SharedPref.lang ??
            'en'),
      );
  }
}