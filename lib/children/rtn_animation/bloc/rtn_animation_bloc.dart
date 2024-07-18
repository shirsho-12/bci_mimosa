import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as devtools show log;

import 'package:mimosa/models/audio_data.dart';
import 'package:mimosa/models/constants.dart';

part 'rtn_animation_event.dart';
part 'rtn_animation_state.dart';

class RtnAnimationBloc extends Bloc<RtnAnimationEvent, RtnAnimationState> {
  Random random = Random();
  List<int> directions = [0, 1, 2, 3, 4, 5];
  List<int> seen = [];
  final player = AudioPlayer();

  RtnAnimationBloc() : super(const RtnAnimationStart()) {
    on<InitialEvent>(_onRtnAnimationInitial);
    on<DistractorEvent>(_onDistractorEvent);
    on<MovingPersonEvent>(_onMovingPersonEvent);
    on<StationaryPersonEvent>(_onStationaryPersonEvent);
    on<PointingPersonEvent>(_onPointingPersonEvent);
  }

  void playAudio(String path, {bool? isLeft}) async {
    // await player.play(DeviceFileSource(path))
    // ;
    if (isLeft is bool) {
      await player.setBalance(isLeft ? -1.0 : 1.0);
    } else {
      await player.setBalance(0.0);
    }
    await player.setVolume(2.0);
    await player.setSourceAsset(path);
    await player.resume();
  }

  void _onRtnAnimationInitial(
    InitialEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    playAudio(RTNAudio.hello, isLeft: event.isLeft);
    emit(const RtnAnimationInitial());
  }

  FutureOr<void> _onDistractorEvent(
    DistractorEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    playAudio(RTNAudio.lookAtThat, isLeft: event.isLeft);
    emit(RtnAnimationDistractor(event.isLeft, duration: event.duration));
  }

  FutureOr<void> _onMovingPersonEvent(
    MovingPersonEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    emit(RtnAnimationWalkingPerson(event.isLeft, duration: event.duration));
  }

  FutureOr<void> _onStationaryPersonEvent(
    StationaryPersonEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    playAudio(RTNAudio.wow);
    emit(RtnAnimationStationaryPerson(duration: event.duration));
  }

  FutureOr<void> _onPointingPersonEvent(
    PointingPersonEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    int direction = directions[random.nextInt(6)];
    while (seen.contains(direction)) {
      direction = directions[random.nextInt(6)];
    }
    seen.add(direction);
    devtools.log('Seen: $seen');
    if (seen.length == 5) {
      seen.clear();
      playAudio(RTNAudio.goodbye);
      emit(const RtnAnimationLevelComplete());
    } else {
      playAudio(RTNAudio.look[direction % 2]);
      emit(RtnAnimationPointingPerson(
          duration: event.duration, direction: direction));
    }
  }
}
