import 'package:flutter/material.dart';

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
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text('Question ${questionIndex + 1}'),
              ),
            ),
            // Display the answer options using RadioButtons
            SizedBox(height: paddingSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      questionIndex++;
                    });
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
