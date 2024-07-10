import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  SharedPreferences? _prefs;

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences? get prefs => _prefs;
}
