import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> removeData(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> clearAllData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> setData(String key, Object value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (value is String) {
      await sharedPreferences.setString(key, value);
      return;
    }

    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return;
    }

    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return;
    }

    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return;
    }

    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
      return;
    }

    throw ArgumentError('Unsupported preference type: ${value.runtimeType}');
  }

  static Future<bool> getBool(String key, [bool defaultValue = false]) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  static Future<double> getDouble(String key, [double defaultValue = 0]) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? defaultValue;
  }

  static Future<int> getInt(String key, [int defaultValue = 0]) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  static Future<String> getString(
    String key, [
    String defaultValue = '',
  ]) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  static Future<List<String>> getStringList(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key) ?? <String>[];
  }

  static Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    try {
      return await _secureStorage.read(key: key) ?? '';
    } on PlatformException {
      await _secureStorage.delete(key: key);
      return '';
    } catch (_) {
      await _secureStorage.delete(key: key);
      return '';
    }
  }

  static Future<void> removeSecuredData(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> clearAllDataAndSecuredData() async {
    await clearAllData();
    await clearAllSecuredData();
  }
}
