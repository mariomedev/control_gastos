import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> saveBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> remove(String key);
}

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  SharedPreferencesServiceImpl();
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  @override
  Future<void> remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }
}
