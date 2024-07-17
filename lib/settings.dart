import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mimosa/models/constants.dart';
import 'package:mimosa/models/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsKeys {
  // face pref settings
  static const initDuration = 'fp_init_duration';
  static const gameDuration = 'fp_game_duration';
  static const maxLevel = 'max_level';
  static const transitionDuration = 'fp_transition_duration';
  static const imageDuration = 'fp_image_duration';

  // rtn settings
  static const rtnInitDuration = 'rtn_init_duration';
  static const distractorDuration = 'rtn_distractor_duration';
  static const movementDuration = 'rtn_move_duration';
  static const wowDuration = 'rtn_wow_duration';
  static const pointingDuration = 'rtn_point_duration';

  static const lowRiskNum = 'low_risk';
  static const mediumRiskNum = 'medium_risk';

  static const keyDarkMode = 'dark_mode';
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // child: Expanded(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchSettingsTile(
            title: "Dark Mode",
            leading: const Icon(Icons.dark_mode),
            settingKey: SettingsKeys.keyDarkMode,
            onChange: (val) {
              setState(() {
                SharedData.setDarkMode(val);
              });
            },
            defaultValue: SharedData.darkMode,
          ),
          SettingsGroup(
            title: 'Questionnaire Thresholds',
            children: [
              TextInputSettingsTile(
                title: "Threshold for low risk classification",
                settingKey: SettingsKeys.lowRiskNum,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a value between 0 and 20";
                  }
                  if (!isNumeric(val) ||
                      double.parse(val) < 0 ||
                      double.parse(val) > 20) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.lowRisk.toString(),
              ),
              TextInputSettingsTile(
                title: "Threshold for medium risk classification",
                settingKey: SettingsKeys.mediumRiskNum,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a value between 0 and 20";
                  }
                  if (!isNumeric(val) ||
                      double.parse(val) < Constants.mediumRisk ||
                      double.parse(val) > 20) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.mediumRisk.toString(),
              ),
            ],
          ),
          SettingsGroup(
            title: 'Face Pref Game Duration (in s - no decimals)',
            children: [
              TextInputSettingsTile(
                title: "Initial Bag Animation Duration",
                settingKey: SettingsKeys.initDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.initDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Full Game Duration",
                settingKey: SettingsKeys.gameDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.gameDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Max Level",
                settingKey: SettingsKeys.maxLevel,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid level";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.maxLevel.toString(),
              ),
              TextInputSettingsTile(
                title: "Transition (between images) Duration",
                settingKey: SettingsKeys.transitionDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.transitionDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Image Duration",
                settingKey: SettingsKeys.imageDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.imageDuration.toString(),
              ),
            ],
          ),
          SettingsGroup(
            title: 'RTN Game Durations (in ms - no decimals)',
            children: [
              TextInputSettingsTile(
                title: "Initial Screen Duration",
                settingKey: SettingsKeys.rtnInitDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.rtnInitDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Distractor Falling Duration",
                settingKey: SettingsKeys.distractorDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.distractorDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Movement to Screen Center Duration",
                settingKey: SettingsKeys.movementDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid level";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.movementDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Between Image Duration",
                settingKey: SettingsKeys.wowDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.wowDuration.toString(),
              ),
              TextInputSettingsTile(
                title: "Pointing Duration",
                settingKey: SettingsKeys.pointingDuration,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a valid duration";
                  }
                  if (!isNumeric(val) || double.parse(val) <= 0) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                initialValue: Constants.pointingDuration.toString(),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  bool isNumeric(String val) {
    return double.tryParse(val) != null;
  }
}
