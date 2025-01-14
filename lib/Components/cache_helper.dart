import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  // Initialize the sharedPreferences instance
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Generic function to save any data type
  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences!.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported data type');
    }
  }

  // Generic function to retrieve any data type
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  // Clear specific key or all data
  static Future<bool> clearKey({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> clearAll() async {
    return await sharedPreferences!.clear();
  }
}
