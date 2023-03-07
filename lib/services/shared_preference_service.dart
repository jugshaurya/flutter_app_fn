import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late SharedPreferences _prefs;
  final String _verificationToken = 'verificationToken';
  final String _authToken = 'authToken';
  final String _craverId = 'craverId';

  SharedPreferenceService(this._prefs);

  static final SharedPreferenceService _preferenceService =
      SharedPreferenceService._();
  SharedPreferenceService._();
  static SharedPreferenceService instance() {
    return _preferenceService;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setVerificationToken(String value) async {
    return await setString(_verificationToken, value);
  }

  String? getVerificationToken() {
    return getString(_verificationToken);
  }

  Future<bool> setAuthToken(String value) async {
    return await setString(_authToken, value);
  }

  String? getAuthToken() {
    return getString(_authToken);
  }

  Future<bool> setCraverId(String value) async {
    return await setString(_craverId, value);
  }

  String? getCraverId() {
    return getString(_craverId);
  }

  Future<void> clearData() async {
    await _prefs.clear();
  }
}
