import 'package:shared_preferences/shared_preferences.dart';

class PreferencesKey {
  static const String token = 'token';

  static const String tokenCreatedTime = 'token_created_time';

  static const String tokenExpireM = 'token_expire_minutes';
}

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static initial() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static addValue(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static addStringList(String key, List<String> value) {
    _sharedPreferences.setStringList(key, value);
  }

  static List<String>? getTextList(String key) {
    return _sharedPreferences.getStringList(key);
  }
}
