import 'dart:async';
import 'dart:math' as math;
import 'dart:developer' as devtools show log;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mimosa/models/audio_data.dart';
import 'package:mimosa/models/constants.dart';
import 'package:mimosa/models/image_data.dart' show FacePrefAssets;
export 'responsive_layout_builder.dart';

/// Steps:
/// Closed bag zooms in and shakes/rotates 30 degrees
/// Bag open animation plays
/// level one starts
/// image -> transition animation -> image ...
/// level complete animation - balloons
/// level two starts

// TODO: Implement fix, use a stack instead of an animation to change images
// TODO: CONVERT TO BLOC

AudioPlayer player = AudioPlayer();

void playAudio(String path) async {
  await player.setVolume(2.0);
  await player.setSourceAsset(path);
  await player.resume();
}

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
  late Animation<double> size;
  late Animation<double> rotate;
  late Animation<String> image;

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
      duration: Duration(seconds: Constants().initDuration),
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
        tween: ConstantTween<String>(FacePrefAssets.bagImage),
        weight: 1 - durationValues[3] - durationValues[4],
      ),
      TweenSequenceItem<String>(
        tween: ConstantTween<String>(FacePrefAssets.bagOpeningImages[0]),
        weight: durationValues[3],
      ),
      TweenSequenceItem<String>(
        tween: ConstantTween<String>(FacePrefAssets.bagOpeningImages[1]),
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
    playAudio(FacePrefAudio.start);
  }

  @override
  void dispose() {
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
                if (image.value == FacePrefAssets.bagOpeningImages[0]) {
                  playAudio(FacePrefAudio.seeInside);
                }
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
                    alignment: Alignment.center,
                  ),
                );
              }),
        ),
        Center(
          child: FutureBuilder(
              future:
                  Future.delayed(Duration(seconds: Constants().initDuration)),
              builder: (context, snapshot) {
                devtools.log(snapshot.connectionState.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  playAudio(FacePrefAudio.seeInside);
                } else {
                  playAudio(FacePrefAudio.hello);
                }
                return snapshot.connectionState == ConnectionState.done
                    ? GameAnimation(
                        width: widget.width, height: widget.height, level: 1)
                    : Container();
              }),
        ),
      ],
    );
  }
}

class GameAnimation extends StatefulWidget {
  const GameAnimation({
    super.key,
    required this.width,
    required this.height,
    required this.level,
    this.gender,
  });
  final double width;
  final double height;
  final int level;
  final String? gender;

  @override
  State<GameAnimation> createState() => _GameAnimationState();
}

class _GameAnimationState extends State<GameAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<AssetImage> imageList;
  late Animation<AssetImage?> image;

  @override
  void initState() {
    super.initState();
    List<String> images;
    switch (widget.level) {
      case 1:
        images = FacePrefAssets.levelOneImages;
        break;
      case 2:
        switch (widget.gender) {
          case 'M':
            images = FacePrefAssets.levelTwoImagesM;
            break;
          case 'F':
            images = FacePrefAssets.levelTwoImagesF;
            break;
          default:
            images = FacePrefAssets.levelTwoImagesM;
        }
        break;
      case 3:
        switch (widget.gender) {
          case 'M':
            images = FacePrefAssets.levelThreeImagesM;
            break;
          case 'F':
            images = FacePrefAssets.levelThreeImagesF;
            break;
          default:
            images = FacePrefAssets.levelThreeImagesM;
        }
        break;
      default:
        images = FacePrefAssets.levelOneImages;
    }

    List<AssetImage> imageList = images
        .map((e) => AssetImage(e))
        .toList()
        .cast<AssetImage>(); // cast to AssetImage

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: Constants().gameDuration),
    )..forward();
    double transitionWeight =
        Constants().transitionWeight! / (imageList.length * 2 - 1);
    double imageWeight = Constants().imageWeight! / (imageList.length * 2 - 1);

    image = TweenSequence<AssetImage?>(<TweenSequenceItem<AssetImage?>>[
      for (int i = 0; i < imageList.length * 2 - 1; i++)
        i % 2 == 1
            ? TweenSequenceItem<AssetImage?>(
                tween: ConstantTween<AssetImage?>(null),
                weight: transitionWeight,
              )
            : TweenSequenceItem<AssetImage>(
                tween: ConstantTween<AssetImage>(imageList[i ~/ 2]),
                weight: imageWeight,
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: Constants().gameDuration)),
        builder: (context, snapshot) {
          devtools.log("second state ${snapshot.connectionState.toString()}");
          if (snapshot.connectionState == ConnectionState.done) {
            playAudio(FacePrefAudio.clap);
            return LevelEndAnimation(
              width: widget.width,
              height: widget.height,
              level: widget.level,
              time: Constants().transitionDuration,
            );
          }
          // playAudio(FacePrefAudio.bounce);
          return AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                playAudio(FacePrefAudio.bounce);
                if (image.value == null) {
                  return MarbleAnimation(
                    time: Constants().imageDuration,
                    width: widget.width,
                    height: widget.height,
                  );
                }
                return SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: Image(image: image.value!),
                );
              });
        });
  }
}

class MarbleAnimation extends StatefulWidget {
  const MarbleAnimation(
      {super.key,
      required this.width,
      required this.height,
      required this.time});
  final double width;
  final double height;
  final int time;

  @override
  State<MarbleAnimation> createState() => _MarbleAnimationState();
}

class _MarbleAnimationState extends State<MarbleAnimation> {
  int index = 0;
  late List<AssetImage> images;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    images = FacePrefAssets.transitionAnimationImages
        .map((e) => AssetImage(e))
        .toList()
        .cast<AssetImage>();
    timer = Timer.periodic(
        Duration(milliseconds: (widget.time * 1000) ~/ images.length), (timer) {
      setState(() {
        index++;
        if (index == images.length) {
          index = 0;
        }
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
    // update index every 1/6th of the time

    return Stack(
      children: [
        Center(
            child: Image(
                image: images[0], width: widget.width, height: widget.height)),
        Center(
          child: Image(
              image: images[index], width: widget.width, height: widget.height),
        ),
      ],
    );
  }
}

class LevelEndAnimation extends StatefulWidget {
  const LevelEndAnimation(
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
  State<LevelEndAnimation> createState() => _LevelEndAnimationState();
}

class _LevelEndAnimationState extends State<LevelEndAnimation> {
  int index = 0;
  int loop = 0;
  late List<AssetImage> images;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    images = FacePrefAssets.balloonImages
        .map((e) => AssetImage(e))
        .toList()
        .cast<AssetImage>();
    // double the speed
    timer = Timer.periodic(
        Duration(milliseconds: (widget.time * 500) ~/ images.length), (timer) {
      setState(() {
        index++;
        if (index == images.length) {
          index = 0;
          if (widget.level < Constants().maxLevel) {
            loop++;
          }
        }
        if (loop == 5) {
          timer.cancel();
        }
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
    // update index every 1/6th of the time

    return loop != 5
        ? Stack(
            children: [
              Center(
                  child: Image(
                      image: images[0],
                      width: widget.width,
                      height: widget.height)),
              Center(
                child: Image(
                    image: images[index],
                    width: widget.width,
                    height: widget.height),
              ),
            ],
          )
        : GameAnimation(
            width: widget.width,
            height: widget.height,
            level: widget.level + 1);
  }
}
