import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          RadioListTile<int>(
            title: const Text('English'),
            subtitle: const Text('English'),
            value: 0,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = 0;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Русский'),
            subtitle: const Text('Russian'),
            value: 1,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = 1;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Українська'),
            subtitle: const Text('Ukrainian'),
            value: 2,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = 2;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Español'),
            subtitle: const Text('Spanish'),
            value: 3,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}

