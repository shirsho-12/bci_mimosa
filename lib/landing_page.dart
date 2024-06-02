import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';
import 'dart:developer' as devtools show log;

import 'package:mimosa/m_chat_instructions.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mimosa'),
      ),
      body: Center(
        child: Flex(
          direction: isScreenWide ? Axis.horizontal : Axis.vertical,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  devtools.log('For Parents');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MChatInstructionsPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.green],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:
                        Text('For Parents', style: MimosaTextStyle.headline1),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  devtools.log('For Children');
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.blue],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('For Children',
                        style: MimosaTextStyle.headline1
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
