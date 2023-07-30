import 'package:flutter/material.dart';

class StageManger with ChangeNotifier {
  String _stage = 'app';

  get stage => _stage;

  setStage(String stage) {
    _stage = stage;
    notifyListeners();
  }
}
