import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../ui/theme_provider.dart';


class FeedbackScreen extends StatelessWidget {
  static String route = '/feedback';

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.feedback),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '\n\n Your feedback is welcome',
                    style: TextStyle(
                      color: themeProvider.isDarkModeEnabled
                          ? Colors.black
                          : Colors.white,
                      fontSize: 28,
                    ),
                    children: [
                      TextSpan(
                        text: '\n\n  Help us improve the Daily Readings',
                        style: TextStyle(
                          color: themeProvider.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '\n       app by sending us information',
                        style: TextStyle(
                          color: themeProvider.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '\nregarding any bugs, misspelled words ',
                        style: TextStyle(
                          color: themeProvider.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '\nor features you think would be useful.',
                        style: TextStyle(
                          color: themeProvider.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/letter.jpg', height: 251, width: 181),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SEND FEEDBACK',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.white
                                : Colors.white,
                          )),
                    ],
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
