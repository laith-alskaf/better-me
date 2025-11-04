import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Required imports
import 'dart:convert';
/// Storage Service - GetX Service
/// يتعامل مع جميع عمليات التخزين المحلي
class StorageService extends GetxService {
  late SharedPreferences _prefs;

  // Singleton pattern
  static StorageService get to => Get.find();

  /// Initialize the service
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ============ String Operations ============

  /// Save a string value
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Get a string value
  String? getString(String key, {String? defaultValue}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  // ============ Int Operations ============

  /// Save an integer value
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Get an integer value
  int? getInt(String key, {int? defaultValue}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  // ============ Double Operations ============

  /// Save a double value
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// Get a double value
  double? getDouble(String key, {double? defaultValue}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  // ============ Boolean Operations ============

  /// Save a boolean value
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Get a boolean value
  bool? getBool(String key, {bool? defaultValue}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  // ============ String List Operations ============

  /// Save a list of strings
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Get a list of strings
  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  // ============ JSON Operations ============

  /// Save a map as JSON string
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  /// Get a JSON string as map
  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Save a list of objects as JSON
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  /// Get a list of objects from JSON
  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  }

  // ============ Utility Operations ============

  /// Check if a key exists
  bool hasKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Remove a key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Clear all data
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  /// Get all keys
  Set<String> getAllKeys() {
    return _prefs.getKeys();
  }

  /// Get all data
  Map<String, dynamic> getAllData() {
    final Map<String, dynamic> allData = {};
    final keys = _prefs.getKeys();
    for (var key in keys) {
      allData[key] = _prefs.get(key);
    }
    return allData;
  }
}

