import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _fontSize = 14.0;

  void _changeFontSize(double newValue) {
    setState(() {
      _fontSize = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: false,
              onChanged: (bool value) {},
            ),
            Text("Font size: $_fontSize",
                style: TextStyle(fontSize: _fontSize)),
            Slider(
              value: _fontSize,
              min: 10,
              max: 30,
              divisions: 20,
              onChanged: _changeFontSize,
            ),
          ],
        ),
      ),
    );
  }
}
