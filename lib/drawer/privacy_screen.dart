import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PrivacyScreen extends StatelessWidget {
  static String route = '/privacy';
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacy),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  text: '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'We do not keep any information about you or your use of the App or your preferences online. All information (such as preference or email address) is kept locally on the App and not uploaded or shared with anyone.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}