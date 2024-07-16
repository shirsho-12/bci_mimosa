import 'package:flutter/material.dart';
import 'package:mimosa/rtn_animation/bloc/bloc.dart';
import 'package:mimosa/models/image_data.dart' as ImageData;
import 'dart:developer' as devtools show log;

import 'widgets.dart';

/// {@template rtn_animation_body}
/// Body of the RtnAnimationPage.
///
/// Add what it does
/// {@endtemplate}
class RtnAnimationBody extends StatelessWidget {
  /// {@macro rtn_animation_body}
  const RtnAnimationBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;
    bool isLeft = true;

    return BlocBuilder<RtnAnimationBloc, RtnAnimationState>(
        builder: (context, state) {
      devtools.log('RtnAnimationBody: state: $state');
      if (state is RtnAnimationInitial) {
        return StationaryPerson(isLeft: isLeft, duration: state.duration);
      }
      if (state is RtnAnimationDistractor) {
        devtools.log('Duration: ${state.duration}');
        return Stack(
          children: [
            StationaryPerson(isLeft: isLeft, duration: -1),
            DistractorWidget(isLeft: isLeft, duration: state.duration)
          ],
        );
      }
      if (state is RtnAnimationWalkingPerson) {
        return MovingPerson(isLeft: isLeft, duration: state.duration);
      }

      if (state is RtnAnimationStationaryPerson) {
        return CenterPerson(duration: state.duration);
      }
      if (state is RtnAnimationPointingPerson) {
        return PointingPerson(
            duration: state.duration, direction: state.direction);
      }

      return Image.asset(
        ImageData.moveImagesF[2],
        width: width,
        height: height,
      );
    });
  }
}
