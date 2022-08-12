import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/bloc/bloc_event.dart';
import 'package:flutter_timer/bloc/bloc_state.dart';

import '../ui/timer_widget.dart';


class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitialState(_duration)) {
    on<TimerStartedEvent>(_onTimerStarted);
    on<TimerTickedEvent>(_onTimerTicked);
    on<TimerPausedEvent>(_onTimerPaused);
    on<TimerResumedEvent>(_onTimerResumed);
    on<TimerResetEvent>(_onTimerReset);
  }

  void _onTimerStarted(TimerStartedEvent event, Emitter<TimerState> emit) {
    emit(TimerRunInProgressState(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTickedEvent(duration: duration)));
  }

  void _onTimerTicked(TimerTickedEvent event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgressState(event.duration)
        : TimerRunCompleteState());
  }

  void _onTimerPaused(TimerPausedEvent event, Emitter<TimerState> emit) {
    if(state is TimerRunInProgressState) {
      _tickerSubscription?.pause();
      emit(TimerRunPauseState(state.duration));
    }
  }

  void _onTimerResumed(TimerResumedEvent event, Emitter<TimerState> emit) {
    if(state is TimerRunPauseState) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgressState(state.duration));
    }
  }

  void _onTimerReset(TimerResetEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitialState(_duration));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
