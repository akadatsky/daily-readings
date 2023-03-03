import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'account_settings_screen.dart';
import '../index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;

  void _toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkModeEnabled = value;
      prefs.setBool('isDarkModeEnabled', value);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  void _loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: "Sam Davies",
              userProfilePic: const AssetImage("assets/profilepic.jpg"),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.indigoAccent,
                  ),
                  title: AppLocalizations.of(context)!.dark_mode,
                  subtitle: AppLocalizations.of(context)!.theme,
                  trailing: Switch.adaptive(
                    value: _isDarkModeEnabled,
                    onChanged: (value) {
                      _toggleDarkMode(value);
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: AppLocalizations.of(context)!.general,
              items: [
                SettingsItem(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountSettingsScreen(),
                      ),
                    );
                  },
                  icons: Icons.account_circle,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.green,
                  ),
                  title: AppLocalizations.of(context)!.account_settings,
                  subtitle:
                      AppLocalizations.of(context)!.privacy_security_language,
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.notifications,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  title: AppLocalizations.of(context)!.notifications,
                  subtitle:
                      AppLocalizations.of(context)!.newsletter_app_updates,
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.logout,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.blue,
                  ),
                  title: AppLocalizations.of(context)!.logout,
                  subtitle: AppLocalizations.of(context)!.sign_out,
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: AppLocalizations.of(context)!.feedback,
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.bug_report,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.teal,
                  ),
                  title: AppLocalizations.of(context)!.report_a_bug,
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.thumb_up,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  title: AppLocalizations.of(context)!.send_feedback,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
