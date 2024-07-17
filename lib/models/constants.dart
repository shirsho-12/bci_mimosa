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
  static final int initDuration = int.parse(
      (Settings.getValue(SettingsKeys.initDuration, defaultValue: "10")!));
  static final int gameDuration = int.parse(
      (Settings.getValue(SettingsKeys.gameDuration, defaultValue: "32")!));
  static final int maxLevel =
      int.parse((Settings.getValue(SettingsKeys.maxLevel, defaultValue: "3")!));
  static final int transitionDuration = int.parse(
      (Settings.getValue(SettingsKeys.transitionDuration, defaultValue: "4")!));
  static final int imageDuration = int.parse(
      (Settings.getValue(SettingsKeys.imageDuration, defaultValue: "5")!));
  static double transitionWeight =
      transitionDuration / (transitionDuration + imageDuration);
  static double imageWeight =
      imageDuration / (transitionDuration + imageDuration);

  static int lowRisk = int.parse(
      (Settings.getValue(SettingsKeys.lowRiskNum, defaultValue: "3")!));
  static int mediumRisk = int.parse(
      (Settings.getValue(SettingsKeys.mediumRiskNum, defaultValue: "8")!));

  static final int rtnInitDuration = int.parse(
      (Settings.getValue(SettingsKeys.rtnInitDuration, defaultValue: "5000")!));
  static final int distractorDuration = int.parse((Settings.getValue(
      SettingsKeys.distractorDuration,
      defaultValue: "5000")!));
  static final int movementDuration = int.parse((Settings.getValue(
      SettingsKeys.movementDuration,
      defaultValue: "8000")!));
  static final int wowDuration = int.parse(
      (Settings.getValue(SettingsKeys.wowDuration, defaultValue: "3000")!));
  static final int pointingDuration = int.parse((Settings.getValue(
      SettingsKeys.pointingDuration,
      defaultValue: "3000")!));

  static final bool darkMode =
      Settings.getValue(SettingsKeys.keyDarkMode, defaultValue: false)!;
}
