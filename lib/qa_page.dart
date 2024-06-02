import 'package:flutter/material.dart';
import 'package:mimosa/models/question_set.dart';

//TODO: Make the sizing dynamic to orientaion

class QuestionPage extends StatefulWidget {
  QuestionPage({super.key});
  final QuestionSet questionSet = QuestionSet();

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int questionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mimosa: M-CHAT-R'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Display the question using RichText
              widget.questionSet.questions[questionIndex]
                  .createQuestionWidget(),
              // Display the answer options using RadioButtons
              const SizedBox(height: 64.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 3.0,
                    child: Radio(
                      value: true,
                      groupValue:
                          widget.questionSet.questions[questionIndex].answer,
                      onChanged: (value) {
                        setState(() {
                          widget.questionSet.questions[questionIndex].answer =
                              value;
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
                          widget.questionSet.questions[questionIndex].answer,
                      onChanged: (value) {
                        setState(() {
                          widget.questionSet.questions[questionIndex].answer =
                              value;
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.5),
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
                    child: const Text('Previous',
                        style: TextStyle(fontSize: 24.0)),
                  ),
                  const SizedBox(width: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      if (questionIndex <
                          widget.questionSet.questions.length - 1) {
                        setState(() {
                          if (widget.questionSet.questions[questionIndex]
                                  .answer !=
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
                      }
                    },
                    child: const Text('Next', style: TextStyle(fontSize: 24.0)),
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
