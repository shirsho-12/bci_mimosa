import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;
import 'package:mimosa/children/rtn_animation/bloc/bloc.dart';

export 'rtn_animation_body.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.duration, required this.isLeft});
  final int duration;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: duration)),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            context.read<RtnAnimationBloc>().add(InitialEvent(isLeft: isLeft));
          }
          return Container(
            color: Colors.yellow, // Set the background color to yellow
            child: Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.pink, // Set the box color to pink
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Bibi's Home",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class StationaryPerson extends StatelessWidget {
  final bool isLeft;
  final int duration;
  final String imagePath;
  const StationaryPerson(
      {super.key,
      required this.isLeft,
      required this.duration,
      required this.imagePath});

  Alignment getAlignment(bool side) {
    return side ? const Alignment(-1.5, 0) : const Alignment(1.5, 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: duration)),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          context.read<RtnAnimationBloc>().add(DistractorEvent(isLeft: isLeft));
        }
        return Align(
          alignment: getAlignment(isLeft),
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}

class DistractorWidget extends StatefulWidget {
  final bool isLeft;
  final int duration;
  final String imagePath;
  const DistractorWidget(
      {super.key,
      required this.isLeft,
      required this.duration,
      required this.imagePath});

  @override
  State<DistractorWidget> createState() => _DistractorWidgetState();
}

class _DistractorWidgetState extends State<DistractorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> alignment;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..forward();

    alignment = Tween<double>(begin: -0.8, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    // ..addListener(() {
    // setState(() {});
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: widget.duration)),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            context
                .read<RtnAnimationBloc>()
                .add(MovingPersonEvent(isLeft: widget.isLeft));
          }
          return AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Align(
                    alignment:
                        Alignment(widget.isLeft ? 0.9 : -0.9, alignment.value),
                    child: Image.asset(
                      widget.imagePath,
                      width: width * 0.3,
                      height: height * 0.3,
                    ));
              });
        });
  }
}

class MovingPerson extends StatefulWidget {
  final bool isLeft;
  final int duration;
  final String imagePath;
  const MovingPerson(
      {super.key,
      required this.isLeft,
      required this.duration,
      required this.imagePath});

  @override
  State<MovingPerson> createState() => _MovingPersonState();
}

class _MovingPersonState extends State<MovingPerson>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> position;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..forward();

    position = Tween<double>(begin: widget.isLeft ? -1.5 : 1.5, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: widget.duration)),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          context.read<RtnAnimationBloc>().add(StationaryPersonEvent());
        }
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Align(
              alignment: Alignment(position.value, 0),
              child: Image.asset(
                widget.imagePath,
                width: width,
                height: height,
              ),
            );
          },
        );
      },
    );
  }
}

class CenterPerson extends StatelessWidget {
  final int duration;
  final String imagePath;
  const CenterPerson(
      {super.key, required this.duration, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: duration)),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          context.read<RtnAnimationBloc>().add(PointingPersonEvent());
        }
        return Center(
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}

class PointingPerson extends StatelessWidget {
  final int duration;
  final int direction;
  final String imagePath;
  const PointingPerson(
      {super.key,
      required this.duration,
      required this.direction,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: duration)),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          context.read<RtnAnimationBloc>().add(StationaryPersonEvent());
        }
        return Center(
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}

class Background extends StatefulWidget {
  const Background(
      {super.key,
      required this.width,
      required this.height,
      required this.level,
      required this.time,
      required this.imagePaths});

  final double width;
  final double height;
  final int level;
  final int time;
  final List<String> imagePaths;

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
        index = (index + 1) % widget.imagePaths.length;
      });
    });
    List<String> temp = widget.imagePaths + widget.imagePaths;
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
