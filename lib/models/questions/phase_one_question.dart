import 'package:flutter/material.dart';

class PhaseOneQuestion {
  String question;
  TextSpan? explanationTextSpan;
  bool? answer;

  PhaseOneQuestion({required this.question, this.explanationTextSpan});

  void setExplanationTextSpan(TextSpan explanationTextSpan) {
    this.explanationTextSpan = explanationTextSpan;
  }

  void setAnswer(bool? answer) {
    this.answer = answer;
  }

  bool? getAnswer() {
    return answer;
  }

  Widget createQuestionWidget() {
    return RichText(
      text: TextSpan(
        text: question,
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          if (explanationTextSpan != null) explanationTextSpan!,
        ],
      ),
    );
  }
}
