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
///
///

// List<int> rotations = [0, 15, -15, 0];
class ChildrenGameAnimation extends StatefulWidget {
  final double width;
  final double height;
  const ChildrenGameAnimation(
      {super.key, required this.width, required this.height});

  @override
  State<ChildrenGameAnimation> createState() => _ChildrenGameAnimationState();
}

class _ChildrenGameAnimationState extends State<ChildrenGameAnimation> {
  late final Timer timer;
  int _index = 0;
  late List<Widget> animations;

  @override
  void initState() {
    animations = [
      BagRotateAnimation(width: widget.width, height: widget.height),
      LoadingScreen(width: widget.width, height: widget.height),
    ];
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _index = (_index + 1) % animations.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: animations[_index],
    );
  }
}

class LoadingScreen extends StatefulWidget {
  final double width;
  final double height;
  const LoadingScreen({super.key, required this.width, required this.height});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final Timer timer;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    //   rootNode = NodeWithSize(Size(widget.width, widget.height));
    //   await _loadAssets(DefaultAssetBundle.of(context));

    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _index = (_index + 1) % transitionAnimationImages.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SpriteWidget(rootNode);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      key: UniqueKey(),
      child: Image.asset(
        transitionAnimationImages[_index],
        width: widget.width,
        height: widget.height,
        key: UniqueKey(),
      ),
    );
  }
}

class BagRotateAnimation extends StatefulWidget {
  final double width;
  final double height;
  const BagRotateAnimation(
      {super.key, required this.width, required this.height});

  @override
  State<BagRotateAnimation> createState() => _BagRotateAnimationState();
}

class _BagRotateAnimationState extends State<BagRotateAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        })
        ..forward();
  late final _sizeController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  @override
  void initState() {
    super.initState();
    _sizeController.forward(); // Start the size animation
  }

  @override
  void dispose() {
    _controller.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  late final Animation<double> _sizeAnimation = Tween<double>(
    begin: 0.5,
    end: 0.75,
  ).animate(CurvedAnimation(
    parent: _sizeController,
    curve: Curves.easeIn,
  ));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _sizeAnimation.value,
          child: RotationTransition(
            turns: Tween(begin: -0.05, end: 0.05).animate(_controller),
            child: Stack(
              children: [
                if (_controller.value < 1.0) // Scale animation
                  Image.asset(
                    bagImage,
                    width: widget.width,
                    height: widget.height,
                    key: UniqueKey(),
                  ),
                if (_controller.value >= 1.0) // Current animation
                  Image.asset(
                    bagImage,
                    width: widget.width,
                    height: widget.height,
                    key: UniqueKey(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
