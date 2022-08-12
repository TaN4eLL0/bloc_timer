import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/bloc.dart';
import 'package:flutter_timer/bloc/bloc_event.dart';
import 'package:flutter_timer/bloc/bloc_state.dart';

class TimerAction extends StatelessWidget {
  const TimerAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (state is TimerInitialState) ...[
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(
                        TimerStartedEvent(duration: state.duration),
                      ),
                  child: Icon(Icons.play_arrow),
                ),
              ],
              if (state is TimerRunInProgressState) ...[
                FloatingActionButton(
                  child: Icon(Icons.pause),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerPausedEvent()),
                ),
                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResetEvent()),
                ),
              ],
              if (state is TimerRunPauseState) ...[
                FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResumedEvent()),
                ),
                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResetEvent()),
                ),
              ],
              if (state is TimerRunCompleteState) ...[
                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () => context.read<TimerBloc>().add(
                        TimerResetEvent(),
                      ),
                ),
              ],
            ],
          );
        });
  }
}
