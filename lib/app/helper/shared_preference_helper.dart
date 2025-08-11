import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';


import '../../data/nurse/model/nurse/user_detail_model.dart';
import '../app_constants.dart';

class SharedPrefService {
  static final SharedPrefService instance = SharedPrefService._internal();

  factory SharedPrefService() {
    return instance;
  }

  SharedPrefService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

// Get user
  UserDetails getUser() => UserDetails.fromJson(jsonDecode(SharedPrefService.instance.getString(AppConstants.user)??""));


  Future<bool> clearPrefs() async {
    return await _prefs?.clear() ?? false;
  }
}