import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _curIdx = 2;

  void setIdx(int newIdx) {
    if (_curIdx != newIdx) {
      _curIdx = newIdx;
      notifyListeners();
    }
  }

  int get curIdx => _curIdx;
}
