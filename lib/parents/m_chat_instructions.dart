import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mimosa/app_ui.dart';

class MChatInstructionsPage extends StatelessWidget {
  const MChatInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M-CHAT-R(TM)'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MimosaColors.background,
              MimosaColors.accent.getShadeColor(shadeValue: 15)
            ],
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
                    Text(
                      'Please answer these questions about your child. Keep in mind how your child usually behaves. If you have seen your child do the behavior a few times, but he or she does not usually do it, then please answer no.',
                      style: MimosaTextStyle.headline2,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'The questions will be yes/no select ones.',
                      style: MimosaTextStyle.headline2,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    // Add additional objects here to fill white space
                    MimosaButtonSmall(
                      buttonText: 'Continue',
                      onPressed: () {
                        devtools.log('Continue');
                        Navigator.pushNamed(context, '/qa_page');
                      },
                    ),
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
