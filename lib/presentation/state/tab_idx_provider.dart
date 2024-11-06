import 'package:flutter/material.dart';

class TabIdxProvider extends ChangeNotifier {
  int _currentIdx = 2;

  int get currentIdx => _currentIdx;

  void setIdx(int newIdx) {
    if (_currentIdx != newIdx) {
      _currentIdx = newIdx;
      notifyListeners();
    }
  }
}
