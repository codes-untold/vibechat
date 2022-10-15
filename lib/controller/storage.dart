import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>?> getStringList(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key) ?? [];
  }

  static setStringList(String key, List<String> value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, value);
  }
}
