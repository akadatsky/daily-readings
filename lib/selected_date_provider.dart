import 'package:flutter/material.dart';

class SelectedDateProvider extends ChangeNotifier {
  late DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }
}
