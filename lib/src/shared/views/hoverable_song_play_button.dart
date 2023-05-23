import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/song.dart';
import '../playback/bloc/playback_bloc.dart';
import '../views/hover_toggle.dart';

class HoverableSongPlayButton extends StatelessWidget {
  const HoverableSongPlayButton({
    super.key,
    required this.song,
    required this.child,
    this.size = const Size(50, 50),
    this.hoverMode = HoverMode.replace,
  });

  final Song song;
  final Widget child;
  final Size size;
  final HoverMode hoverMode;

  @override
  Widget build(BuildContext context) {
    return HoverToggle(
      hoverChild: Center(
        child: GestureDetector(
          child: const Icon(Icons.play_arrow),
          onTap: () => BlocProvider.of<PlaybackBloc>(context)
              .add(PlaybackEvent.changeSong(song)),
        ),
      ),
      mode: hoverMode,
      size: size,
      child: child,
    );
  }
}
