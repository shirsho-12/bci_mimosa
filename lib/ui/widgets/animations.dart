import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:mimosa/models/image_data.dart';
export 'responsive_layout_builder.dart';

/// Steps:
/// Closed bag zooms in and shakes/rotates 30 degrees
/// Bag open animation plays
/// level one starts
/// image -> transition animation -> image ...
/// level complete animation - balloons
/// level two starts

// List<int> rotations = [0, 15, -15, 0];

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
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _bagOpenController;
  int numRotations = 0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _bagOpenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _startScaleAnimation();
    _startRotationAnimation();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _bagOpenController.dispose();
    super.dispose();
  }

  Future _startScaleAnimation() async {
    devtools.log('Starting scale animation');
    try {
      await _scaleController.forward().orCancel;
      // await _scaleController.reverse().orCancel;
      // await _startRotationAnimation();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      devtools.log('Animation got canceled');
    }
  }

  Future _startRotationAnimation() async {
    devtools.log('Starting rotation animation');
    try {
      await _rotationController.forward().orCancel;
      await _rotationController.reverse().orCancel;
      setState(() {
        numRotations++;
      });
      if (numRotations < 2) {
        _startRotationAnimation();
      } else {
        _rotationController.stop();
        await _startBagOpenAnimation();
      }
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      devtools.log('Animation got canceled');
    }
  }

  Future _startBagOpenAnimation() async {
    devtools.log('Starting bag open animation');
    try {
      await _bagOpenController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      devtools.log('Animation got canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameAnimationStack(
        scaleController: _scaleController,
        rotationController: _rotationController,
        bagOpenController: _bagOpenController,
        width: widget.width,
        height: widget.height);
  }
}

class GameAnimationStack extends StatefulWidget {
  final double width;
  final double height;
  final Animation<double> _rotationController;
  final Animation<double> _bagOpenController;
  final Animation<double> _scaleController;
  // final Animation<double> _rotationController;

  GameAnimationStack(
      {super.key,
      required this.width,
      required this.height,
      required Animation<double> scaleController,
      required Animation<double> rotationController,
      required Animation<double> bagOpenController})
      : _rotationController = rotationController,
        _bagOpenController = bagOpenController,
        _scaleController = scaleController;

  late final Animation<double> scaleAnimation = Tween<double>(
    begin: 0.7,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  ));
  late final Animation<double> rotationAnimation = Tween<double>(
    begin: -0.3,
    end: 0.3,
  ).animate(CurvedAnimation(
    parent: _rotationController,
    curve: Curves.easeInOut,
  ));

  late final AnimatedSwitcher bagOpenAnimation = AnimatedSwitcher(
      duration: const Duration(milliseconds: 2000),
      child: _bagOpenController.isCompleted
          ? Image.asset(bagOpeningImages[1], width: width, height: height)
          : Image.asset(bagOpeningImages[0], width: width, height: height));
  int index = 0;

  @override
  State<GameAnimationStack> createState() => _GameAnimationStackState();
}

class _GameAnimationStackState extends State<GameAnimationStack> {
  @override
  Widget build(BuildContext context) {
    if (widget._scaleController.isCompleted) {
      setState(() {
        widget.index = 1;
      });
    }
    if (widget._bagOpenController.isCompleted) {
      setState(() {
        // widget.index = 2;
      });
    }
    return Stack(
      children: [
        // !_rotationController.isCompleted
        widget.index == 0
            ? AnimatedBuilder(
                animation: widget._rotationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: widget.scaleAnimation.value,
                    child: Transform.rotate(
                      angle: widget.rotationAnimation.value,
                      child: Image.asset(
                        bagImage,
                        width: widget.width,
                        height: widget.height,
                      ),
                    ),
                  );
                },
              )
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                key: UniqueKey(),
                child: widget._bagOpenController.isCompleted
                    ? Image.asset(bagOpeningImages[1],
                        width: widget.width, height: widget.height)
                    : Image.asset(bagOpeningImages[0],
                        width: widget.width, height: widget.height)),
      ],
    );
  }
}
