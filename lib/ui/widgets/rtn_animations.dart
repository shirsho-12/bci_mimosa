import 'dart:async';
import 'dart:ffi';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:mimosa/models/constants.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;

/// Steps:
///  Person to left/right
///  Object falls on opposite side
///  Person moves to center
///  Person looks left, forward, top left, up, top right, down, points to sides
///  6 directions with objects on each side

class ChildrenGameAnimation extends StatefulWidget {
  final double width;
  final double height;
  const ChildrenGameAnimation(
      {super.key, required this.width, required this.height});

  @override
  State<ChildrenGameAnimation> createState() => _ChildrenGameAnimationState();
}

class _ChildrenGameAnimationState extends State<ChildrenGameAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late String imagePath;
  late Stopwatch timer;

  late List<double> durationValues;

  void _setDurationValues() {
    List<int> durationsInSeconds = Constants.durationsInSeconds;
    double total = durationsInSeconds.reduce((a, b) => a + b).toDouble();
    durationValues = durationsInSeconds.map((e) => e / total).toList();
  }

  @override
  void initState() {
    super.initState();
    _setDurationValues();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: Constants.initDuration),
    )..forward();
    timer = Stopwatch()..start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Stream<int> getStatus() async* {
    try {
      if (timer.elapsedMilliseconds % 1000 == 0) {
        yield timer.elapsedMilliseconds ~/ 1000;
      }
    } catch (e) {
      devtools.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(
          width: widget.width,
          height: widget.height,
          level: 3,
          time: 200,
        ),
        StreamBuilder(
            stream: getStatus(),
            builder: (context, snapshot) {
              devtools.log(snapshot.data.toString());
              return snapshot.data == null ||
                      snapshot.data! < 2 ||
                      snapshot.data! > 8
                  ? Container()
                  : SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: Distractor(
                        width: widget.width,
                        height: widget.height,
                        side: 0,
                        time: 5, // TODO
                      ),
                    );
            })
        // PersonWidget(
        //   width: widget.width * 0.1,
        //   height: widget.height * 0.1,
        //   side: 0,
        //   gender: 1,
        //   time: 20,
        // ),
      ],
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

class Distractor extends StatefulWidget {
  const Distractor(
      {super.key,
      required this.width,
      required this.height,
      required this.side,
      required this.time});

  final double width;
  final double height;
  final int time;
  final int side;
  @override
  State<Distractor> createState() => _DistractorState();
}

class _DistractorState extends State<Distractor>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late TweenSequence<Alignment> alignment;
  late Animation<Alignment> alignmentAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time))
      ..forward();
    //TODO: Forward when duration hits 2s

    alignment = TweenSequence<Alignment>(
      <TweenSequenceItem<Alignment>>[
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: widget.side == 1 ? Alignment.topLeft : Alignment.topRight,
            end:
                widget.side == 1 ? Alignment.bottomLeft : Alignment.bottomRight,
          ),
          weight: 1,
        ),
      ],
    );
    alignmentAnimation = controller.drive(alignment);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Align(
          alignment: alignmentAnimation.value,
          child: Image.asset(
            ImageData.distractors[widget.side],
            width: widget.width * 0.15,
            height: widget.height * 0.15,
          ),
        );
      },
    );
  }
}

class PersonWidget extends StatefulWidget {
  const PersonWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.side,
      required this.gender,
      required this.time});
  final double width;
  final double height;
  final int time;
  final int side; // 0: left, 1: right
  final int gender; // 0: male, 1: female

  @override
  State<PersonWidget> createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<String> image;
  late Animation<double> xVal;

  late List<double> durationValues;

  void _setDurationValues() {
    List<int> durationsInSeconds = Constants.durationsInSeconds;
    double total = durationsInSeconds.reduce((a, b) => a + b).toDouble();
    durationValues = durationsInSeconds.map((e) => e / total).toList();
  }

  @override
  void initState() {
    super.initState();
    _setDurationValues();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time))
      ..forward();
    xVal = Tween<double>(
      begin: widget.side == 0 ? 0.1 : 0.9,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          durationValues[0],
          durationValues[1],
          curve: Curves.easeInOut,
        ),
      ),
    );

    image = TweenSequence<String>(
      <TweenSequenceItem<String>>[
        TweenSequenceItem<String>(
          tween: ConstantTween<String>(ImageData.moveImagesF[3]),
          weight: durationValues[2],
        ),
        TweenSequenceItem<String>(
          tween: ConstantTween<String>(ImageData.moveImagesF[widget.side]),
          weight: durationValues[3],
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isAnimating) devtools.log('Animating');
    if (controller.isCompleted) {
      dispose();
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          transform: Matrix4.identity()..translate(xVal.value),
          child: Image.asset(
            image.value,
            // alignment: Alignment.center,
          ),
        );
      },
    );
  }
}
