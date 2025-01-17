import 'package:daily_readings/login/register_screen.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DrawerScreen extends StatefulWidget {
  final Author? author;
  final ValueChanged<Author> onAuthorChanged;

  const DrawerScreen(
      {Key? key, required this.author, required this.onAuthorChanged})
      : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/bookcover.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(''),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.daily_readings_selection),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<Author>(
                title: Text(AppLocalizations.of(context)!.spurgeon),
                value: Author.spurgeon,
                groupValue: widget.author,
                onChanged: (Author? value) {
                  setState(() {
                    widget.onAuthorChanged(value!);
                  });
                  Navigator.pop(context);
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              const Divider(height: 0, color: Colors.grey),
              RadioListTile<Author>(
                title: Text(AppLocalizations.of(context)!.ryle),
                value: Author.ryle,
                groupValue: widget.author,
                onChanged: (Author? value) {
                  setState(() {
                    widget.onAuthorChanged(value!);
                  });
                  Navigator.pop(context);
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            leading: const Icon(Icons.home),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              await Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.route,
                ModalRoute.withName('/'),
              ).then((value) => {setState(() {})});
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.register),
            leading: const Icon(Icons.account_circle),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              await Navigator.pushNamed(
                  context, RegisterScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.bible),
            leading: const Icon(Icons.book),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              await Navigator.pushNamed(
                  context, BibleScreen.route); // Navigate to the home page
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.stats),
            leading: const Icon(Icons.stacked_bar_chart),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, StatsScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.daily_goals),
            leading: const Icon(Icons.looks_one_sharp),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, GoalsScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.about),
            leading: const Icon(Icons.people_alt_rounded),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, AboutScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.feedback),
            leading: const Icon(Icons.format_quote),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, FeedbackScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.copyright),
            leading: const Icon(Icons.copyright),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, CopyrightScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.privacy),
            leading: const Icon(Icons.back_hand),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, PrivacyScreen.route);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.help),
            leading: const Icon(Icons.question_mark),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, HelpScreen.route);
            },
          ),
          Text("${AppLocalizations.of(context)!.app_version}: X.X.X", textAlign: TextAlign.center),
          Text("${AppLocalizations.of(context)!.content_version}: XXX", textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
