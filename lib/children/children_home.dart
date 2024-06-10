import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';
import 'dart:developer' as devtools show log;

class ChildrenHomePage extends StatelessWidget {
  const ChildrenHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mimosa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MimosaButtonLarge(
                buttonText: 'Calibrate',
                onPressed: () {
                  devtools.log('Calibrate button pressed');
                }),
            const SizedBox(height: 16.0),
            MimosaButtonLarge(
                buttonText: 'Game 1',
                onPressed: () {
                  devtools.log('Game 1 button pressed');
                  Navigator.pushNamed(context, '/face_pref_game');
                }),
            const SizedBox(height: 16.0),
            MimosaButtonLarge(
                buttonText: 'Game 2',
                onPressed: () {
                  devtools.log('Game 2 button pressed');
                  Navigator.pushNamed(context, '/rtn_game');
                }),
          ],
        ),
      ),
    );
  }
}
