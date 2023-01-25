import 'package:flutter/material.dart';

import '../index.dart';

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
          const ListTile(
            title: Text('Daily Readings Selection'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<Author>(
                title: const Text('Spurgeon'),
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
                title: const Text('J.C. Ryle'),
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
            title: const Text('Home'),
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
            title: const Text('Bible'),
            leading: const Icon(Icons.book),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              await Navigator.pushNamed(
                  context, BibleScreen.route); // Navigate to the home page
            },
          ),
          ListTile(
            title: const Text('Stats'),
            leading: const Icon(Icons.stacked_bar_chart),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, StatsScreen.route);
            },
          ),
          ListTile(
            title: const Text('Daily Goals'),
            leading: const Icon(Icons.looks_one_sharp),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, GoalsScreen.route);
            },
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(Icons.people_alt_rounded),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, AboutScreen.route);
            },
          ),
          ListTile(
            title: const Text('Feedback'),
            leading: const Icon(Icons.format_quote),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, FeedbackScreen.route);
            },
          ),
          ListTile(
            title: const Text('Copyright'),
            leading: const Icon(Icons.copyright),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, CopyrightScreen.route);
            },
          ),
          ListTile(
            title: const Text('Privacy'),
            leading: const Icon(Icons.back_hand),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, PrivacyScreen.route);
            },
          ),
          ListTile(
            title: const Text('Help'),
            leading: const Icon(Icons.question_mark),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, HelpScreen.route);
            },
          ),
          const Text("App version: X.X.X", textAlign: TextAlign.center),
          const Text("Content version: XXX", textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
