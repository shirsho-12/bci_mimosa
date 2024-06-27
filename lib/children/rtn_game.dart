import 'package:flutter/material.dart';
import 'package:mimosa/ui/widgets/animations.dart';

class RTNGame extends StatefulWidget {
  RTNGame({Key? key}) : super(key: key);

  @override
  State<RTNGame> createState() => _RTNGameState();
}

class _RTNGameState extends State<RTNGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mimosa - Bibi's Home"),
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
