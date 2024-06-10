import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mimosa/models/questions/phase_two_question.dart';

// import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

class PhaseTwoQuestionSet extends ChangeNotifier {
  List<PhaseTwoQuestion> questionSet = [];
  //TODO: find directory
  static const _localPath = 'assets/yml/p_two_questions.yaml';

  Future<File> get _localQuestionsFile async {
    const path = _localPath;
    return File(path);
  }

  Future<void> loadPhaseTwoQuestionSet() async {
    List<SubQuestion> subquestions = [];

    final file = await _localQuestionsFile;
    final data = await file.readAsString();
    final yaml = loadYaml(data);
    final questions = yaml['questions'];
    int idx = 0;
    for (var question in questions) {
      // final q = PhaseTwoQuestion(
      //   question: question['question'],
      //   answer: question['answer'],
      //   exampleType: question['exampleType'],
      // );
      // this.questions.add(q);
      String qText = question[idx];
      String preText = question['pretext'];
      for (var q in question['subquestions']) {
        final sq = SubQuestion(
          question: q['question'],
          exampleType: q['exampleType'],
        );
        subquestions.add(sq);
      }
      var passCriterion = question['pass'];

      final q = PhaseTwoQuestion(
        baseString: qText,
        preText: preText,
        subQuestions: subquestions,
        passCriteria: passCriterion,
        followUp: question['follow-up'],
        followUpCriteria:
            question['follow-up'] != null ? question['follow-up']['on'] : null,
      );
      questionSet.add(q);
    }
    notifyListeners();
  }

  // PhaseTwoQuestionSet() async {
  //   final data = await rootBundle.loadString('assets/yml/p_two_questions.yaml');
  // }
}

// main() async {
//   final pTwoQuestionSet = PhaseTwoQuestionSet();
//   await pTwoQuestionSet.loadPhaseTwoQuestionSet();
//   print(pTwoQuestionSet.questionSet);
// }
