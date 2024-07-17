import 'package:flutter/material.dart';
import 'package:mimosa/children/face_pref_game.dart';
import 'package:mimosa/children/rtn_game.dart';
import 'package:mimosa/landing_page.dart';
import 'package:mimosa/parents/phase_two.dart';
import 'package:mimosa/parents/phase_two_instructions.dart';
import 'package:mimosa/parents/score_next_step.dart';
import 'package:mimosa/parents/m_chat_instructions.dart';
import 'package:mimosa/parents/qa_page.dart';
import 'package:mimosa/children/children_home.dart';
import 'package:mimosa/settings.dart';

class RouteGenerator {
  static const String homepage = '/';
  static const String config = '/settings';
  static const String parents = '/parents';
  static const String children = '/children_home';
  static const String qaPage = '/phase_one';
  static const String scoreNextSteps = '/score_next_steps';

  static const String phaseTwoInstructions = '/phase_two_instructions';
  static const String phaseTwo = '/phase_two';

  static const String facePrefGame = '/face_pref_game';
  static const String rtnGame = '/rtn_game';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case config:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case parents:
        return MaterialPageRoute(builder: (_) => const MChatInstructionsPage());
      case qaPage:
        return MaterialPageRoute(builder: (_) => const PhaseOne());
      case children:
        return MaterialPageRoute(builder: (_) => const ChildrenHomePage());
      case scoreNextSteps:
        return MaterialPageRoute(builder: (_) => const ScoreNextStep());
      case phaseTwoInstructions:
        return MaterialPageRoute(builder: (_) => const PhaseTwoInstructions());
      case phaseTwo:
        return MaterialPageRoute(builder: (_) => const PhaseTwo());
      case facePrefGame:
        return MaterialPageRoute(builder: (_) => const FacePreferenceGame());
      case rtnGame:
        return MaterialPageRoute(builder: (_) => const RTNGame());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('404 Route Not Found'),
                  ),
                ));
    }
  }
}
