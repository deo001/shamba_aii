import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── Language ────────────────────────────────────────────────────────
  static const _langKey = 'app_language';
  static String? getLanguage() => _prefs.getString(_langKey);
  static Future<void> setLanguage(String lang) => _prefs.setString(_langKey, lang);

  // ── Onboarding ──────────────────────────────────────────────────────
  static const _onboardKey = 'onboarding_done';
  static bool isOnboardingDone() => _prefs.getBool(_onboardKey) ?? false;
  static Future<void> setOnboardingDone() => _prefs.setBool(_onboardKey, true);

  // ── Auth ────────────────────────────────────────────────────────────
  static const _authKey = 'user_logged_in';
  static bool isLoggedIn() => _prefs.getBool(_authKey) ?? false;
  static Future<void> setLoggedIn(bool v) => _prefs.setBool(_authKey, v);

  static const _phoneKey = 'user_phone';
  static String? getPhone() => _prefs.getString(_phoneKey);
  static Future<void> setPhone(String phone) => _prefs.setString(_phoneKey, phone);

  static const _userIdKey = 'user_uid';
  static String? getUserId() => _prefs.getString(_userIdKey);
  static Future<void> setUserId(String uid) => _prefs.setString(_userIdKey, uid);

  static Future<void> clearUser() async {
    await _prefs.remove(_authKey);
    await _prefs.remove(_phoneKey);
    await _prefs.remove(_userIdKey);
  }
}
