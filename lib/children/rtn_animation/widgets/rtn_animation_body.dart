import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mimosa/models/audio_data.dart';
import 'package:mimosa/children/rtn_animation/bloc/bloc.dart';
import 'package:mimosa/models/image_data.dart';
import 'dart:developer' as devtools show log;

import 'widgets.dart';

/// {@template rtn_animation_body}
/// Body of the RtnAnimationPage.
///
/// Add what it does
/// {@endtemplate}
class RtnAnimationBody extends StatefulWidget {
  /// {@macro rtn_animation_body}
  const RtnAnimationBody({super.key});

  @override
  State<RtnAnimationBody> createState() => _RtnAnimationBodyState();
}

class _RtnAnimationBodyState extends State<RtnAnimationBody> {
  late int level;
  late bool isMale;
  late RTNAssets assets;
  late bool isLeft;

  void playAudio(String path) async {
    final player = AudioPlayer();
    await player.setVolume(2.0);
    await player.setSourceAsset(path);
    await player.resume();
  }

  @override
  void initState() {
    super.initState();
    level = 1;
    isMale = DateTime.now().millisecondsSinceEpoch % 2 == 0; // randomizing
    isLeft = DateTime.now().millisecondsSinceEpoch % 2 == 0; // randomizing
    assets = RTNAssets(level, isMale ? 'm' : 'f');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.4;

    return BlocBuilder<RtnAnimationBloc, RtnAnimationState>(
        builder: (context, state) {
      devtools.log('RtnAnimationBody: state: $state');
      if (state is RtnAnimationStart) {
        playAudio(RTNAudio.start);
        return GameScreen(duration: state.duration, isLeft: isLeft);
      }
      if (state is RtnAnimationInitial) {
        return StationaryPerson(
            isLeft: isLeft,
            duration: state.duration,
            imagePath: assets.moveImages[2]);
      }
      if (state is RtnAnimationDistractor) {
        devtools.log('Duration: ${state.duration}');
        return Stack(
          children: [
            StationaryPerson(
                isLeft: isLeft, duration: -1, imagePath: assets.moveImages[2]),
            DistractorWidget(
                isLeft: isLeft,
                duration: state.duration,
                imagePath: assets.distractors[isLeft ? 0 : 1])
          ],
        );
      }
      if (state is RtnAnimationWalkingPerson) {
        return MovingPerson(
          isLeft: isLeft,
          duration: state.duration,
          imagePath: assets.moveImages[isLeft ? 0 : 1],
        );
      }

      if (state is RtnAnimationStationaryPerson) {
        return CenterPerson(
            duration: state.duration, imagePath: assets.moveImages[3]);
      }
      if (state is RtnAnimationPointingPerson) {
        return PointingPerson(
            duration: state.duration,
            direction: state.direction,
            imagePath: assets.pointImages[state.direction]);
      }

      if (state is RtnAnimationLevelComplete && level < 3) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            level++;
            assets = RTNAssets(level, isMale ? 'm' : 'f');
            context.read<RtnAnimationBloc>().add(InitialEvent(isLeft: isLeft));
          });
        });
      }

      return Image.asset(
        assets.moveImages[2],
        width: width,
        height: height,
      );
    });
  }
}
