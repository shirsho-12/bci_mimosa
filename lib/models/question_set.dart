import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';

import 'questions/phase_one_question.dart';

class QuestionSet extends ChangeNotifier {
  List<PhaseOneQuestion> questions = <PhaseOneQuestion>[];

  QuestionSet() {
    questions.add(
      PhaseOneQuestion(
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
      PhaseOneQuestion(
        question: 'Have you ever wondered if your child might be deaf?',
      ),
    );

    questions.add(
      PhaseOneQuestion(
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
      PhaseOneQuestion(
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
      PhaseOneQuestion(
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

    questions.add(
      PhaseOneQuestion(
        question:
            'Does your child point with one finger to ask for something or to get help?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: 'pointing to a snack or toy that is out of reach)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );
    questions.add(
      PhaseOneQuestion(
        question:
            'Does your child point with one finger to show you something interesting?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text:
                  'pointing to an airplane in the sky or a big truck in the road)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );
    questions.add(
      PhaseOneQuestion(
        question: 'Is your child interested in other children?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text:
                  'does your child watch other children, smile at them, or go to them?)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );
    questions.add(
      PhaseOneQuestion(
        question:
            'Does your child show you things by bringing them to you or holding them up for you to see – not to get help, but just to share?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: 'showing you a flower, a stuffed animal, or a toy truck)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );
    questions.add(
      PhaseOneQuestion(
        question: 'Does your child respond when you call his or her name?',
        explanationTextSpan: TextSpan(
          text: '\n(FOR EXAMPLE ',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text:
                  'does he or she look up, talk or babble, or stop what he or she is doing when you call his or her name?)',
              style: MimosaTextStyle.bodyText1,
            ),
          ],
        ),
      ),
    );
    questions.add(
      PhaseOneQuestion(
          question:
              'When you smile at your child, does he or she smile back at you?'),
    );

    questions.add(PhaseOneQuestion(
      question: 'Does your child get upset by everyday noises?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: 'a vacuum cleaner or loud music)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));

    questions.add(PhaseOneQuestion(
      question: 'Does your child walk?',
    ));

    questions.add(PhaseOneQuestion(
      question:
          'Does your child look you in the eye when you are talking to him or her, playing with him or her, or dressing him or her?',
    ));

    questions.add(PhaseOneQuestion(
      question: 'Does your child try to copy what you do?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: 'wave bye-bye, clap, or make a funny noise when you do)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));

    questions.add(PhaseOneQuestion(
      question:
          'If you turn your head to look at something, does your child look around to see what you are looking at?',
    ));

    questions.add(PhaseOneQuestion(
      question: 'Does your child try to get you to watch him or her?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text:
                'does your child look at you for praise, or say “look” or “watch me”)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));

    questions.add(PhaseOneQuestion(
      question:
          'Does your child understand when you tell him or her to do something?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text:
                'if you don’t point, can your child understand “put the book on the chair” or “bring me the blanket”)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));

    questions.add(PhaseOneQuestion(
      question:
          'If something new happens, does your child look at your face to see how you feel about it?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text:
                ', if he or she hears a strange or funny noise, or sees a new toy, will he or she look at your face?)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));

    questions.add(PhaseOneQuestion(
      question: 'Does your child like movement activities?',
      explanationTextSpan: TextSpan(
        text: '\n(FOR EXAMPLE ',
        style: const TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text:
                'being swung or bounced on your knee, or does he or she run to you to be picked up and swung around?)',
            style: MimosaTextStyle.bodyText1,
          ),
        ],
      ),
    ));
  }

  int get length => questions.length;

  PhaseOneQuestion getQuestion(int index) {
    return questions[index];
  }

  void setAnswer(int index, bool answer) async {
    questions[index].setAnswer(answer);
    notifyListeners();
  }

  bool? getAnswer(int index) {
    return questions[index].getAnswer();
  }

  int getScore() {
    int score = 0;
    for (PhaseOneQuestion question in questions) {
      if (question.getAnswer() == true) {
        score++;
      }
    }
    return score;
  }

  void reset() {
    for (PhaseOneQuestion question in questions) {
      question.setAnswer(null);
    }
    notifyListeners();
  }
}
