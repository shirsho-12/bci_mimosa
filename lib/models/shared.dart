import 'package:mimosa/models/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static late final SharedPreferences instance;
  static Future<SharedPreferences> init() async {
    instance = await SharedPreferences.getInstance();
    // instance.clear();
    return instance;
  }

  static void clear() {
    instance.clear();
  }

  static bool get darkMode =>
      instance.getBool(SettingsKeys.keyDarkMode) ?? false;
  static Future<void> setDarkMode(bool darkMode) async {
    await instance.setBool(SettingsKeys.keyDarkMode, darkMode);
  }

  static String get initDuration =>
      instance.getString(SettingsKeys.initDuration) ?? '';
  static Future<void> setInitDuration(String duration) async {
    await instance.setString(SettingsKeys.initDuration, duration);
  }

  static String get gameDuration =>
      instance.getString(SettingsKeys.gameDuration) ?? '';
  static Future<void> setGameDuration(String duration) async {
    await instance.setString(SettingsKeys.gameDuration, duration);
  }

  static String get maxLevel => instance.getString(SettingsKeys.maxLevel) ?? '';
  static Future<void> setMaxLevel(String level) async {
    await instance.setString(SettingsKeys.maxLevel, level);
  }

  static String get transitionDuration =>
      instance.getString(SettingsKeys.transitionDuration) ?? '';
  static Future<void> setTransitionDuration(String duration) async {
    await instance.setString(SettingsKeys.transitionDuration, duration);
  }

  static String get imageDuration =>
      instance.getString(SettingsKeys.imageDuration) ?? '';
  static Future<void> setImageDuration(String duration) async {
    await instance.setString(SettingsKeys.imageDuration, duration);
  }

  static String get rtnInitDuration =>
      instance.getString(SettingsKeys.rtnInitDuration) ?? '';
  static Future<void> setRtnInitDuration(String duration) async {
    await instance.setString(SettingsKeys.rtnInitDuration, duration);
  }

  static String get distractorDuration =>
      instance.getString(SettingsKeys.distractorDuration) ?? '';
  static Future<void> setDistractorDuration(String duration) async {
    await instance.setString(SettingsKeys.distractorDuration, duration);
  }

  static String get movementDuration =>
      instance.getString(SettingsKeys.movementDuration) ?? '';
  static Future<void> setMovementDuration(String duration) async {
    await instance.setString(SettingsKeys.movementDuration, duration);
  }

  static String get wowDuration =>
      instance.getString(SettingsKeys.wowDuration) ?? '';
  static Future<void> setWowDuration(String duration) async {
    await instance.setString(SettingsKeys.wowDuration, duration);
  }

  static String get pointingDuration =>
      instance.getString(SettingsKeys.pointingDuration) ?? '0';
  static Future<void> setPointingDuration(String duration) async {
    await instance.setString(SettingsKeys.pointingDuration, duration);
  }

  static String get lowRiskNum =>
      instance.getString(SettingsKeys.lowRiskNum) ?? '';
  static Future<void> setLowRiskNum(String num) async {
    await instance.setString(SettingsKeys.lowRiskNum, num);
  }

  static String get mediumRiskNum =>
      instance.getString(SettingsKeys.mediumRiskNum) ?? '';
  static Future<void> setMediumRiskNum(String num) async {
    await instance.setString(SettingsKeys.mediumRiskNum, num);
  }
}
