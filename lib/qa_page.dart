import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';
import 'package:mimosa/models/question_set.dart';
import 'package:provider/provider.dart';

//TODO: Make the sizing dynamic to orientaion

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.height * 0.05;
    int totalQuestions = context.read<QuestionSet>().questions.length;
    int? total;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mimosa: M-CHAT-R'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6.0),
            child: LinearProgressIndicator(
              // backgroundColor: Colors.red.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MimosaColors.accent),
              value: (questionIndex) / totalQuestions,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Display the question using RichText
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: context
                      .read<QuestionSet>()
                      .getQuestion(questionIndex)
                      .createQuestionWidget(),
                ),
              ),
              // Display the answer options using RadioButtons
              SizedBox(height: paddingSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 3.0,
                    child: Radio(
                      value: true,
                      groupValue:
                          context.read<QuestionSet>().getAnswer(questionIndex),
                      onChanged: (value) {
                        setState(() {
                          context
                              .read<QuestionSet>()
                              .setAnswer(questionIndex, value!);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 8.0), // Add padding between Radio widgets
                  const Text(
                    'Yes',
                    style: TextStyle(fontSize: 32.0), // Increase the font size
                  ),
                  const SizedBox(
                      width: 32.0), // Add more padding between Radio widgets
                  Transform.scale(
                    scale: 3.0,
                    child: Radio(
                      value: false,
                      groupValue:
                          context.read<QuestionSet>().getAnswer(questionIndex),
                      onChanged: (value) {
                        setState(() {
                          context
                              .read<QuestionSet>()
                              .setAnswer(questionIndex, value!);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 8.0), // Add padding between Radio widgets
                  const Text(
                    'No',
                    style: TextStyle(fontSize: 32.0), // Increase the font size
                  ),
                ],
              ),
              SizedBox(height: paddingSize * 6),
              // Display the navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (questionIndex > 0) {
                        setState(() {
                          questionIndex--;
                        });
                      }
                    },
                    child: const ButtonText(buttonText: 'Previous'),
                  ),
                  SizedBox(width: paddingSize),
                  ElevatedButton(
                    onPressed: () {
                      if (questionIndex < totalQuestions - 1) {
                        setState(() {
                          if (context
                                  .read<QuestionSet>()
                                  .getAnswer(questionIndex) !=
                              null) {
                            questionIndex++;
                          } else {
                            // Display an error message if the user has not selected an answer
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select an answer before proceeding.'),
                              ),
                            );
                          }
                        });
                      } else {
                        // Calculate the total score
                        total = context.read<QuestionSet>().getScore();
                        // Display the total score
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Risk Score'),
                              content: Text('Score: $total'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Navigate to the next screen
                                    Navigator.pushNamed(
                                      context,
                                      '/score_next_steps',
                                      arguments: total,
                                    );
                                  },
                                  child: const Text('Next'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const ButtonText(buttonText: 'Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
