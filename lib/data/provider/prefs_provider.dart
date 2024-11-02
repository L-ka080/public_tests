import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider extends ChangeNotifier {
  SharedPreferences preferences;

  PrefsProvider({
    required this.preferences,
  });

  void setNewPreferences(SharedPreferences preferences) {
    this.preferences = preferences;
    notifyListeners();
  }
}
