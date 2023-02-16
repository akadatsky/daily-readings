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
  int? selectedLanguage;

  void _saveSelectedLanguage(int value) {
    SharedPref.addLang(AllLocale.all[value].languageCode);
    setState(() {
      selectedLanguage = value;
    });
    Provider.of<SettingProvider>(context, listen: false).updateLocal(AllLocale.all[value].languageCode);
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
            title: Text(AppLocalizations.of(context)!.langEN),
            subtitle: Text('English'),
            value: 0,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: Text(AppLocalizations.of(context)!.langES),
            subtitle: Text('Spanish'),
            value: 1,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: Text(AppLocalizations.of(context)!.langRU),
            subtitle: Text('Russian'),
            value: 2,
            groupValue: selectedLanguage,
            onChanged: (value) {
              _saveSelectedLanguage(value!);
            },
          ),
          RadioListTile<int>(
            title: Text(AppLocalizations.of(context)!.langUK),
            subtitle: Text('Ukrainian'),
            value: 3,
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
