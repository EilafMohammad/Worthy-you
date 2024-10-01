import 'package:shared_preferences/shared_preferences.dart';

class MyPrefUtils {
  static String voiceTemplate = "voice-template";
  static String isLoggedIn = "is_logged_in";
  static String isSliderSeen = "is_slider_seen";
  static String userName = "user_name";
  static String userEmail = "user_email";
  static String userPassword = "user_Password";
  static String userId = "user_id";
  static String isGoogleLoggedIn = "google_logged_in";
  static String isFacebookLoggedIn = "facebook_logged_in";
  static String careerCompetence = "careerCompetence";
  static String socialAcceptance = "socialAcceptance";
  static String appearance = "appearance";
  static String academicPerformance = "academicPerformance";


  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<void> putString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> putBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<void> clearCaches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
