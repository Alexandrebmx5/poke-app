import 'package:shared_preferences/shared_preferences.dart';

class DatabaseManager {
  static DatabaseManager _instance = new DatabaseManager._internal();
  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setBool(bool value, String key) async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.setBool(key, value);
  }

  Future<bool> boolForKey(String key, {bool defaultValue = false}) async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<void> setStringForKey(String value, String key) async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.setString(key, value);
  }

  Future<void> setStringListForKey(List<String> value, String key) async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.setStringList(key, value);
  }

  Future<void> setIntForKey(int value, String key) async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.setInt(key, value);
  }

  Future<String?> valueForKey(String key) async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getString(key);
  }

  Future<bool?> valueForBoolKey(String key) async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getBool(key);
  }

  Future<List<String>?> valueListForKey(String key) async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getStringList(key);
  }

  Future<int?> valueIntForKey(String key) async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getInt(key);
  }

  Future<bool> deleteWithName(String key) async {
    final sharedPreferences = await _prefs;
    return await sharedPreferences.remove(key);
  }

  Future<void> logout() async {
    var sharedPreferences = await _prefs;
    await sharedPreferences.clear();
  }
}
