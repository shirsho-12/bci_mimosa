import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';
import 'dart:developer' as devtools show log;

// TODO: Ensure this is the only screen on the stack
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mimosa'),
        actions: [
          IconButton(
              onPressed: () {
                devtools.log('Settings');
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Flex(
            direction: isScreenWide ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    devtools.log('For Parents');
                    Navigator.pushNamed(context, '/parents');
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
              const SizedBox(width: 16, height: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    devtools.log('For Children');
                    Navigator.pushNamed(context, '/children_home');
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
      ),
    );
  }
}
