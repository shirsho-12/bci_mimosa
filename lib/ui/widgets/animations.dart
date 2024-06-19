import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;
export 'responsive_layout_builder.dart';

/// Steps:
/// Closed bag zooms in and shakes/rotates 30 degrees
/// Bag open animation plays
/// level one starts
/// image -> transition animation -> image ...
/// level complete animation - balloons
/// level two starts

// TODO: Implement fix, use a stack instead of an animation to change images

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
  String imagePath = ImageData.bagImage;
  late Animation<double> size;
  late Animation<double> rotate;
  late Animation<String> image;
  final int duration = 5;

  late List<double> durationValues;

  void _setDurationValues() {
    List<int> durationsInSeconds = [
      0, // start
      2, // scale up
      4, // rotate
      2, // half-open bag
      2, // open bag
    ];
    double total = durationsInSeconds.reduce((a, b) => a + b).toDouble();
    durationValues = durationsInSeconds.map((e) => e / total).toList();
  }

  @override
  void initState() {
    super.initState();
    _setDurationValues();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    )..forward();
    size = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(durationValues[0], durationValues[1],
            curve: Curves.easeInOut),
      ),
    );
    rotate = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          durationValues[1],
          durationValues[2],
          curve: Curves.easeInOut,
        )));

    image = TweenSequence<String>(<TweenSequenceItem<String>>[
      TweenSequenceItem<String>(
        tween: ConstantTween<String>(ImageData.bagImage),
        weight: 1 - durationValues[3] - durationValues[4],
      ),
      TweenSequenceItem<String>(
        tween: ConstantTween<String>(ImageData.bagOpeningImages[0]),
        weight: durationValues[3],
      ),
      TweenSequenceItem<String>(
        tween: ConstantTween<String>(ImageData.bagOpeningImages[1]),
        weight: durationValues[4],
      ),
    ]).animate(
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
    // _scaleController.dispose();
    // _rotationController.dispose();
    // _bagOpenController.dispose();
    controller.dispose();
    super.dispose();
  }

  Stream<AnimationStatus> getStatus() async* {
    try {
      yield controller.status;
    } catch (e) {
      devtools.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Container(
                  width: widget.width,
                  height: widget.height,
                  transform: Matrix4.identity()
                    ..translate(widget.width / 2, widget.height / 2)
                    ..scale(size.value)
                    ..rotateY(rotate.value)
                    ..rotateZ(rotate.value)
                    ..translate(-widget.width / 2, -widget.height / 2),
                  // ..rotateZ(rotate.value),
                  child: Image.asset(
                    image.value,
                    // width: widget.width * size.value,
                    // height: widget.height * size.value,
                    alignment: Alignment.center,
                  ),
                );
              }),
        ),
        FutureBuilder(
            future: Future.delayed(Duration(seconds: duration)),
            builder: (context, snapshot) {
              devtools.log(snapshot.connectionState.toString());
              return snapshot.connectionState == ConnectionState.done
                  ? Positioned(
                      top: widget.height / 2,
                      right: widget.width / 2,
                      child: const Text("WELL WELL WELL",
                          style: TextStyle(fontSize: 30, color: Colors.red)))
                  : Container();
            }),
      ],
    );
  }
}
