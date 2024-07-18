part of 'rtn_animation_bloc.dart';

abstract class RtnAnimationEvent {
  const RtnAnimationEvent();
}

/// {@template custom_rtn_animation_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class InitialEvent extends RtnAnimationEvent {
  InitialEvent({required this.isLeft});
  final bool isLeft;
  final int duration = Constants().rtnInitDuration;
}

class DistractorEvent extends RtnAnimationEvent {
  DistractorEvent({required this.isLeft});
  final bool isLeft;
  final int duration = Constants().distractorDuration;
}

class MovingPersonEvent extends RtnAnimationEvent {
  MovingPersonEvent({
    required this.isLeft,
  });
  final bool isLeft;
  final int duration = Constants().movementDuration;
}

class StationaryPersonEvent extends RtnAnimationEvent {
  StationaryPersonEvent();
  final int duration = Constants().wowDuration;
}

class PointingPersonEvent extends RtnAnimationEvent {
  PointingPersonEvent();
  final int duration = Constants().pointingDuration;
}

class GameEndEvent extends RtnAnimationEvent {
  const GameEndEvent();
}
