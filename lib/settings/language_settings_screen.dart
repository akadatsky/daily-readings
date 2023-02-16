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
  int? val;
  int idx = 0;

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
            Wrap(
              children: List.generate(AllLocale.all.length, (index) {
                return RadioListTile(
                  title: Text(
                    AllLocale.all[index].languageCode == 'en'
                        ? AppLocalizations.of(context)!.langEN
                        : AllLocale.all[index].languageCode == 'es'
                            ? AppLocalizations.of(context)!.langES
                            : AllLocale.all[index].languageCode == 'ru'
                                ? AppLocalizations.of(context)!.langRU
                                : AppLocalizations.of(context)!.langUK,
                  ),
                  value: AllLocale.all[index].languageCode,
                  groupValue: prov.local,
                  onChanged: (String? value) {
                    SharedPref.addLang(value!);
                    prov.updateLocal(value);
                  },
                );
              }),
            ),
          ],
        ));
  }
}
