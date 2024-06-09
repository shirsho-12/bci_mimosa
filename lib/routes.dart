import 'package:flutter/material.dart';
import 'package:mimosa/landing_page.dart';
import 'package:mimosa/score_next_step.dart';
import 'package:mimosa/m_chat_instructions.dart';
import 'package:mimosa/qa_page.dart';

class RouteGenerator {
  static const String homepage = '/';
  static const String parents = '/parents';
  static const String children = '/children';
  static const String qaPage = '/qa_page';
  static const String scoreNextSteps = '/score_next_steps';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case parents:
        return MaterialPageRoute(builder: (_) => const MChatInstructionsPage());
      case qaPage:
        return MaterialPageRoute(builder: (_) => const QuestionPage());
      case children:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('For Children'),
                  ),
                ));
      case scoreNextSteps:
        return MaterialPageRoute(builder: (_) => const ScoreNextStep());

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
