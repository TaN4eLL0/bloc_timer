import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitialState extends TimerState {
  const TimerInitialState(super.duration);

  @override
  String toString() => 'TimerInitialState { duration: $duration }';
}

class TimerRunPauseState extends TimerState {
  const TimerRunPauseState(super.duration);

  @override
  String toString() => 'TimerRunPauseState { duration: $duration }';
}

class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(super.duration);

  @override
  String toString() => 'TimerRunInProgressState { duration: $duration }';
}

class TimerRunCompleteState extends TimerState {
  const TimerRunCompleteState() : super(0);
}
