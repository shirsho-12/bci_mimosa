part of 'rtn_animation_bloc.dart';

/// {@template rtn_animation_state}
/// RtnAnimationState description
/// {@endtemplate}
class RtnAnimationState extends Equatable {
  /// {@macro rtn_animation_state}
  const RtnAnimationState({
    this.duration = 2000,
  });

  /// Duration the state should be displayed
  final int duration;

  @override
  List<Object> get props => [duration];

  /// Creates a copy of the current RtnAnimationState with property changes
  RtnAnimationState copyWith({
    int? customProperty,
  }) {
    return RtnAnimationState(
      duration: customProperty ?? duration,
    );
  }
}

/// {@template rtn_animation_initial}
/// The initial state of RtnAnimationState
/// {@endtemplate}
class RtnAnimationInitial extends RtnAnimationState {
  const RtnAnimationInitial({this.shake = false}) : super();

  final bool shake;
}

class RtnAnimationDistractor extends RtnAnimationState {
  const RtnAnimationDistractor(this.isLeft, {required super.duration})
      : super();

  final bool isLeft;
}

class RtnAnimationWalkingPerson extends RtnAnimationState {
  const RtnAnimationWalkingPerson(this.isLeft, {required super.duration})
      : super();

  final bool isLeft;
}

class RtnAnimationStationaryPerson extends RtnAnimationState {
  const RtnAnimationStationaryPerson({required super.duration}) : super();
}

class RtnAnimationPointingPerson extends RtnAnimationState {
  const RtnAnimationPointingPerson(
      {required this.direction, required super.duration})
      : super();

  final int direction;
}

class RtnAnimationLevelComplete extends RtnAnimationState {
  const RtnAnimationLevelComplete() : super();
}
