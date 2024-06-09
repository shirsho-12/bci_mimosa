import 'package:flutter/material.dart';

class Question {
  String question;
  TextSpan? explanationTextSpan;
  bool? answer;

  Question({required this.question, this.explanationTextSpan});

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
