import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../ui/theme_provider.dart';

class HelpScreen extends StatelessWidget {
  static String route = '/help';

  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.help),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: 'What is in the App?',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text:
                          '\nThe App consists of a reading for each day, with a Bible section to read (at the top), a meditation from C H Spurgeon which has been lightly modernized, a “for thought and prayer" section at the end of each reading and a hymn to read or sing, along with the accompanying music. \nAlso in the App is a complete Bible (the English Standard Version or ESV) which is accessible from the left ‘slide out’ menu.',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: '\nHow to use the App?\n',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text:
                          '\nThere are readings for every morning and evening of the year. We suggest the following:\n',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                          '   •	Start by considering the verse provided by C H Spurgeon (in the image at the top of each reading)',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                          ' \n  •	Click on the Bible reading icon and read the suggested passage of Scripture. This has been chosen to add context or further insight',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: " \n  •	Read C H Spurgeon's comments",
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                          " \n  •	Sing or read the hymn next (you need not sing aloud, especially if you are wearing headphones!)",
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                          " \n  •	Finally, read the ‘For Thought and Prayer’ section and commit the matters you have been considering to the Lord in prayer",
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                          '\n\nOf course, this is only a suggestion and we would love to hear more from you on how you are using the App. You can send us feedback through the ‘feedback section’ from the slide out menu.\n',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.black
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: -2,
                          child: Icon(
                            Icons.wb_incandescent_outlined,
                            color: themeProvider.isDarkModeEnabled
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text('START-UP HELP',
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
        ),
      );
    });
  }
}
