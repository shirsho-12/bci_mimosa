import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as devtools show log;

part 'rtn_animation_event.dart';
part 'rtn_animation_state.dart';

class RtnAnimationBloc extends Bloc<RtnAnimationEvent, RtnAnimationState> {
  Random random = Random();
  List<int> directions = [0, 1, 2, 3, 4, 5];
  List<int> seen = [];

  RtnAnimationBloc() : super(const RtnAnimationInitial()) {
    on<InitialEvent>(_onRtnAnimationInitial);
    on<DistractorEvent>(_onDistractorEvent);
    on<MovingPersonEvent>(_onMovingPersonEvent);
    on<StationaryPersonEvent>(_onStationaryPersonEvent);
    on<PointingPersonEvent>(_onPointingPersonEvent);
  }

  void _onRtnAnimationInitial(
    InitialEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    emit(const RtnAnimationInitial());
  }

  FutureOr<void> _onDistractorEvent(
    DistractorEvent event,
    Emitter<RtnAnimationState> emit,
  ) {
    emit(RtnAnimationDistractor(event.isLeft, duration: event.duration));
    // _tickerSubscription?.cancel();
    // _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
    //     (duration) => emit(RtnAnimationDistractor(event.isLeft, duration)));
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
      emit(const RtnAnimationLevelComplete());
    } else {
      emit(RtnAnimationPointingPerson(
          duration: event.duration, direction: direction));
    }
  }
}
