import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'account_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
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
                  title: 'Dark mode',
                  subtitle: "Theme",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "General",
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
                  title: 'Account Settings',
                  subtitle: "Privacy, Security, Language",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.notifications,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  title: 'Notifications',
                  subtitle: "Newsletter, App updates",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.logout,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.blue,
                  ),
                  title: 'Logout',
                  subtitle: "Sign out of the account",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Feedback",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.bug_report,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.teal,
                  ),
                  title: "Report A Bug",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.thumb_up,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  title: "Send Feedback",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
