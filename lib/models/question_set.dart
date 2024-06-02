import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';

import 'question.dart';

class QuestionSet {
  List<Question> questions = <Question>[];

  QuestionSet() {
    questions.add(
      Question(
        question:
            'If you point at something across the room, does your child look at it?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: MimosaTextStyle.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'if you point at a toy or an animal, does your child look at the toy or animal?)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );

    questions.add(
      Question(
        question: 'Have you ever wondered if your child might be deaf?',
      ),
    );

    questions.add(
      Question(
        question: 'Does your child play pretend or make-believe?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text:
                  ' pretend to drink from an empty cup, pretend to talk on a phone, or pretend to feed a doll or stuffed animal?)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );

    questions.add(
      Question(
        question: 'Does your child like climbing on things?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: 'furniture, playground equipment, or stairs)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );

    questions.add(
      Question(
        question: 'Does your child make ',
        explanationTextSpan: TextSpan(
          text: 'unusual',
          style: const TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              decoration: TextDecoration.underline),
          children: <TextSpan>[
            const TextSpan(
              text: ' finger movements near his or her eyes?',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            TextSpan(
              text: '\n(FOR EXAMPLE ',
              style: MimosaTextStyle.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'waving his or her fingers near his or her eyes)',
              style: MimosaTextStyle.bodyText1.copyWith(
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
