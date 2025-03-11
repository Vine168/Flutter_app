import 'package:flutter/material.dart';

class ColorCounters with ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;
  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;
  void incrementRedTapCount() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementBlueTapCount() {
    _blueTapCount++;
    notifyListeners();
  }
}