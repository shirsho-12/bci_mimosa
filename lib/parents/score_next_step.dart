import 'package:flutter/material.dart';
import 'package:mimosa/models/question_set.dart';
import 'package:provider/provider.dart';

class ScoreNextStep extends StatelessWidget {
  const ScoreNextStep({super.key});

  @override
  Widget build(BuildContext context) {
    String risklevel = '';
    String caseString = ''; // Contains explanation of risk level and next steps
    int score = context.read<QuestionSet>().getScore();
    if (score < 3) {
      risklevel = 'low';
      caseString =
          'If your child is under 24 months, schedule a follow-up screening after their second birthday. No further action is needed at this time.';
    } else if (score < 8) {
      risklevel = 'medium';
      caseString = 'Please continue to the next stage of the screening.';
    } else {
      risklevel = 'high';
      caseString =
          'Please contact your child\'s healthcare provider to discuss the results of this screening.';
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Mimosa: M-CHAT-R'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your child\'s ASD risk score is $score. \nThis puts them in the $risklevel risk category.',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            Text(
              caseString,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            risklevel == 'medium'
                ? ElevatedButton(
                    onPressed: () {
                      // context.read<QuestionSet>().reset();
                      Navigator.pushNamed(context, '/phase_two');
                    },
                    child: const Text(
                        'Continue to the next stage of the screening'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context.read<QuestionSet>().reset();
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('Return to the home page'),
                  )
          ],
        ),
      ),
    ));
  }
}
