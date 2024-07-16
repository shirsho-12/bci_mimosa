import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimosa/rtn_animation/rtn_animation.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;

class RTNGame extends StatefulWidget {
  const RTNGame({super.key});

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
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Stack(
            children: [
              Background(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                time: 200,
                level: 3,
              ),
              // ChildrenGameAnimation(
              //     width: MediaQuery.of(context).size.width * 0.75,
              //     height: MediaQuery.of(context).size.height * 0.75),
              const Center(child: RtnAnimationPage())
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatefulWidget {
  const Background(
      {super.key,
      required this.width,
      required this.height,
      required this.level,
      required this.time});

  final double width;
  final double height;
  final int level;
  final int time;

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  int index = 0;
  late List<Center> images;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: widget.time), (timer) {
      setState(() {
        index = (index + 1) % ImageData.backgroundImages.length;
      });
    });
    List<String> temp = ImageData.backgroundImages + ImageData.backgroundImages;
    images = temp
        .map((e) => AssetImage(e))
        .toList()
        .cast<AssetImage>()
        .map((e) => Center(
                child: Image(
              image: e,
              width: widget.width,
              height: widget.height,
              key: ValueKey<int>(index++),
            )))
        .toList();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cancel animation if level 1
    if (widget.level == 1) {
      timer.cancel();
      return images[0];
    }
    if (index >= images.length) index = 0;
    return Stack(
      children: [
        images[0],
        AnimatedSwitcher(
          duration: Duration(milliseconds: widget.time),
          child: images[index],
        ),
      ],
    );
  }
}
