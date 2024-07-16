part of 'rtn_animation_bloc.dart';

abstract class RtnAnimationEvent {
  const RtnAnimationEvent();
}

/// {@template custom_rtn_animation_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class InitialEvent extends RtnAnimationEvent {
  const InitialEvent();
  final int duration = 5000;
}

class DistractorEvent extends RtnAnimationEvent {
  const DistractorEvent({required this.isLeft});
  final bool isLeft;
  final int duration = 5000;
}

class MovingPersonEvent extends RtnAnimationEvent {
  const MovingPersonEvent({
    required this.isLeft,
  });
  final bool isLeft;
  final int duration = 8000;
}

class StationaryPersonEvent extends RtnAnimationEvent {
  const StationaryPersonEvent();
  final int duration = 3000;
}

class PointingPersonEvent extends RtnAnimationEvent {
  const PointingPersonEvent();
  final int duration = 3000;
}

class GameEndEvent extends RtnAnimationEvent {
  const GameEndEvent();
}
