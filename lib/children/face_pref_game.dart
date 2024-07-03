import 'package:flutter/material.dart';
import 'package:mimosa/ui/widgets/rtn_animations.dart';

class FacePreferenceGame extends StatefulWidget {
  const FacePreferenceGame({super.key});

  @override
  State<FacePreferenceGame> createState() => _FacePreferenceGameState();
}

class _FacePreferenceGameState extends State<FacePreferenceGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mimosa - Tofu's Bag"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChildrenGameAnimation(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75),
          ],
        ),
      ),
    );
  }
}
