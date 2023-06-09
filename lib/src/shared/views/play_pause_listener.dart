import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beautiful_app/src/shared/playback/bloc/playback_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../playback/bloc/';
class _PlayPauseIntent extends Intent {
  const _PlayPauseIntent(this.handler);

  final VoidCallback handler;
}

class _PlayPauseAction extends Action<_PlayPauseIntent> {
  @override
  void invoke(_PlayPauseIntent intent) => intent.handler();
}

class PlayPauseListener extends StatelessWidget {
  const PlayPauseListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        _PlayPauseIntent: _PlayPauseAction(),
      },
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.space): _PlayPauseIntent(
            () => BlocProvider.of<PlaybackBloc>(context).add(
              const PlaybackEvent.togglePlayPause(),
            ),
          ),
        },
        child: child,
      ),
    );
  }
}
