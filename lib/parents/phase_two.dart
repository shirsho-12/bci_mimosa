import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mimosa/ui/typography/text_styles.dart';
// TODO: Emphasize most often
class PhaseTwo extends StatefulWidget {
  const PhaseTwo({super.key});

  @override
  State<PhaseTwo> createState() => _PhaseTwoState();
}

class _PhaseTwoState extends State<PhaseTwo> {
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.height * 0.05;
    List<String> questions = [
      'Looks at objects',
      'Points at objects',
      'Looks and comments on objects',
      'Looks if you point at something and say "look!"',
      'Ignores you',
      'Looks around the room randomly',
      'Looks at your finger'
    ];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Mimosa: M-CHAT-R Phase 2'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            value: (questionIndex) / 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            // Display the question using RichText
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                  "If you point at something, what does your child typically do?",
                  style: MimosaTextStyle.bodyText1),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.9,
                child: QuestionCard(questions: questions),
              ),
            ),
            // Display the answer options using RadioButtons
            SizedBox(height: paddingSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // open pop-up with MostOftenSelector
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'Which one does your child do most often?'),
                          content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: MostOftenSelector(questions: questions)),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Done'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class QuestionCard extends StatefulWidget {
  final List<String> questions;

  const QuestionCard({super.key, required this.questions});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int questionIndex = 0;
  List<bool?> answers = List.filled(7, null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.questions[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text('Yes'),
                    Radio(
                      value: true,
                      groupValue: answers[index],
                      onChanged: (value) {
                        setState(() {
                          // questionIndex++;
                          devtools.log('Radio button pressed',
                              name: 'PhaseTwo');
                          answers[index] = true;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    const Text('No'),
                    Radio(
                      value: false,
                      groupValue: answers[index],
                      onChanged: (value) {
                        setState(() {
                          // questionIndex++;
                          devtools.log('Radio button pressed',
                              name: 'PhaseTwo');
                          answers[index] = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MostOftenSelector extends StatefulWidget {
  final List<String> questions;
  const MostOftenSelector({super.key, required this.questions});

  @override
  State<MostOftenSelector> createState() => _MostOftenSelectorState();
}

class _MostOftenSelectorState extends State<MostOftenSelector> {
  int questionIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          return Card(
            color: questionIndex == index ? Colors.blue[100] : Colors.white,
            child: InkWell(
              onTap: () {
                setState(() {
                  questionIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.questions[index],
                        style: const TextStyle(
                          fontSize: 18,
                          // color: questionIndex == index
                          //     ? Colors.blue
                          //     : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
