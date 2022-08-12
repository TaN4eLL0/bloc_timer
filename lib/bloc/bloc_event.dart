import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartedEvent extends TimerEvent {
  final int duration;

  const TimerStartedEvent({required this.duration});
}

class TimerPausedEvent extends TimerEvent {
  const TimerPausedEvent();
}

class TimerResumedEvent extends TimerEvent {
  const TimerResumedEvent();
}

class TimerResetEvent extends TimerEvent {
  const TimerResetEvent();
}

class TimerTickedEvent extends TimerEvent {
  final int duration;
  const TimerTickedEvent({required this.duration});

  @override
  List<Object> get props => [duration];
}
