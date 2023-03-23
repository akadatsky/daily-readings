import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../l10n/all_locales.dart';
import '../l10n/app_local.dart';
import '../l10n/setting_provider.dart';
import '../l10n/shared_pref.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  int selectedLanguage = 0;

  @override
  void initState() {
    super.initState();
    _getSelectedLanguage();
  }

  void _getSelectedLanguage() async {
    SharedPref.getLang().then((value) {
      setState(() {
        selectedLanguage = AllLocale.availableLocales
            .indexWhere((element) => element.languageCode == value);
        if (selectedLanguage == -1) {
          selectedLanguage = 0;
        }
      });
    });
  }

  void _saveSelectedLanguage(int value) {
    SharedPref.addLang(AllLocale.availableLocales[value].languageCode);
    setState(() {
      selectedLanguage = value;
    });
    Provider.of<SettingProvider>(context, listen: false)
        .updateLocal(AllLocale.availableLocales[value].languageCode);
  }

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    SettingProvider prov = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RadioListTile<int>(
            title: const Text('English'),
            subtitle: const Text('English'),
            value: 0,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: const Text('Español'),
            subtitle: const Text('Spanish'),
            value: 1,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: const Text('Português'),
            subtitle: const Text('Portuguese'),
            value: 2,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: const Text('Русский'),
            subtitle: const Text('Russian'),
            value: 3,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: const Text('Українська'),
            subtitle: const Text('Ukrainian'),
            value: 4,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
        ],
      ),
    );
  }
}
