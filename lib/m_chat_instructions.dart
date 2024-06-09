import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mimosa/qa_page.dart';

class MChatInstructionsPage extends StatelessWidget {
  const MChatInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M-CHAT-R(TM)'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Please answer these questions about your child. Keep in mind how your child usually behaves. If you have seen your child do the behavior a few times, but he or she does not usually do it, then please answer no.',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'The questions will be yes/no select ones.',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    // Add additional objects here to fill white space
                    ElevatedButton(
                      onPressed: () {
                        devtools.log('Continue');
                        Navigator.pushNamed(context, '/qa_page');
                      },
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: Colors.white,
                        // backgroundColor: Colors.blue[200],
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.04,
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // Decreased border radius for less curved edges
                        ),
                        textStyle: const TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Continue'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
