import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsKeys {
  static const initDuration = 'fp_init_duration';
  static const gameDuration = 'fp_game_duration';
  static const maxLevel = 'max_level';
  static const transitionDuration = 'fp_transition_duration';
  static const imageDuration = 'fp_image_duration';

  static const rtnInitDuration = 'rtn_init_duration';
  static const distractorDuration = 'rtn_distractor_duration';
  static const movementDuration = 'rtn_move_duration';
  static const wowDuration = 'rtn_wow_duration';
  static const pointingDuration = 'rtn_point_duration';

  static const lowRiskNum = 'low_risk';
  static const mediumRiskNum = 'medium_risk';

  static const keyDarkMode = 'dark_mode';
}

class Constants {
  static List<int> durationsInSeconds = [
    0, // start
    2, // scale up
    4, // rotate
    2, // half-open bag
    2, // open bag
  ];
  int initDuration = int.parse(
      (Settings.getValue(SettingsKeys.initDuration, defaultValue: "10")!));
  int gameDuration = int.parse(
      (Settings.getValue(SettingsKeys.gameDuration, defaultValue: "32")!));
  int maxLevel =
      int.parse((Settings.getValue(SettingsKeys.maxLevel, defaultValue: "3")!));
  int transitionDuration = int.parse(
      (Settings.getValue(SettingsKeys.transitionDuration, defaultValue: "4")!));
  int imageDuration = int.parse(
      (Settings.getValue(SettingsKeys.imageDuration, defaultValue: "5")!));

  double? transitionWeight;
  double? imageWeight;

  Constants() {
    transitionWeight =
        transitionDuration / (transitionDuration + imageDuration);
    imageWeight = imageDuration / (transitionDuration + imageDuration);
  }

  int lowRisk = int.parse(
      (Settings.getValue(SettingsKeys.lowRiskNum, defaultValue: "3")!));
  int mediumRisk = int.parse(
      (Settings.getValue(SettingsKeys.mediumRiskNum, defaultValue: "8")!));

  int rtnInitDuration = int.parse(
      (Settings.getValue(SettingsKeys.rtnInitDuration, defaultValue: "5000")!));
  int distractorDuration = int.parse((Settings.getValue(
      SettingsKeys.distractorDuration,
      defaultValue: "5000")!));
  int movementDuration = int.parse((Settings.getValue(
      SettingsKeys.movementDuration,
      defaultValue: "8000")!));
  int wowDuration = int.parse(
      (Settings.getValue(SettingsKeys.wowDuration, defaultValue: "3000")!));
  int pointingDuration = int.parse((Settings.getValue(
      SettingsKeys.pointingDuration,
      defaultValue: "3000")!));

  bool darkMode =
      Settings.getValue(SettingsKeys.keyDarkMode, defaultValue: false)!;
}
