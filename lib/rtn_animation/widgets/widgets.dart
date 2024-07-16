import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;
import 'package:mimosa/rtn_animation/bloc/bloc.dart';

export 'rtn_animation_body.dart';

class StationaryPerson extends StatelessWidget {
  final bool isLeft;
  final int duration;
  const StationaryPerson(
      {super.key, required this.isLeft, required this.duration});

  Alignment getAlignment(bool side) {
    return side ? const Alignment(-1.5, 0) : const Alignment(1.5, 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;
    if (duration != -1) {
      Future.delayed(
        Duration(milliseconds: duration),
        () {},
      ).then(
        (_) {
          context.read<RtnAnimationBloc>().add(DistractorEvent(isLeft: isLeft));
        },
      );
    }

    return Align(
      alignment: getAlignment(isLeft),
      child: Image.asset(
        ImageData.moveImagesF[2],
        width: width,
        height: height,
      ),
    );
  }
}

class DistractorWidget extends StatefulWidget {
  final bool isLeft;
  final int duration;
  const DistractorWidget(
      {super.key, required this.isLeft, required this.duration});

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

    Future.delayed(
      Duration(milliseconds: widget.duration),
      () {},
    ).then(
      (_) {
        context
            .read<RtnAnimationBloc>()
            .add(MovingPersonEvent(isLeft: widget.isLeft));
      },
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Align(
              alignment: Alignment(widget.isLeft ? 0.9 : -0.9, alignment.value),
              child: Image.asset(
                ImageData.distractors[0],
                width: width * 0.3,
                height: height * 0.3,
              ));
        });
  }
}

class MovingPerson extends StatefulWidget {
  final bool isLeft;
  final int duration;
  const MovingPerson({super.key, required this.isLeft, required this.duration});

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

    Future.delayed(
      Duration(milliseconds: widget.duration),
      () {},
    ).then(
      (_) {
        context.read<RtnAnimationBloc>().add(const StationaryPersonEvent());
      },
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Align(
          alignment: Alignment(position.value, 0),
          child: Image.asset(
            ImageData.moveImagesF[widget.isLeft ? 0 : 1],
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}

class CenterPerson extends StatelessWidget {
  final int duration;
  const CenterPerson({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    Future.delayed(
      Duration(milliseconds: duration),
      () {},
    ).then(
      (_) {
        context.read<RtnAnimationBloc>().add(const PointingPersonEvent());
      },
    );
    return Center(
      child: Image.asset(
        ImageData.moveImagesF[3],
        width: width,
        height: height,
      ),
    );
  }
}

class PointingPerson extends StatelessWidget {
  final int duration;
  final int direction;
  const PointingPerson(
      {super.key, required this.duration, required this.direction});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    Future.delayed(
      Duration(milliseconds: duration),
      () {},
    ).then(
      (_) {
        context.read<RtnAnimationBloc>().add(const StationaryPersonEvent());
      },
    );
    return Center(
      child: Image.asset(
        ImageData.pointImagesF[direction],
        width: width,
        height: height,
      ),
    );
  }
}
