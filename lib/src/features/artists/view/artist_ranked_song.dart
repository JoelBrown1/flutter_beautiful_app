import 'package:flutter/material.dart';
import 'package:flutter_beautiful_app/src/shared/views/image_clipper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/extensions.dart';
import '../../../shared/classes/artist.dart';
import '../../../shared/classes/ranked_song.dart';
import 'package:flutter_beautiful_app/src/shared/views/adaptive_table.dart';
import '../../../shared/playback/bloc/playback_bloc.dart';

import '../../../shared/views/hoverable_song_play_button.dart';

class ArtistRankedSongs extends StatelessWidget {
  const ArtistRankedSongs({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTable<RankedSong>(
      items: artist.songs,
      breakpoint: 450,
      itemBuilder: (song, index) {
        return ListTile(
          leading: ClippedImage(song.image.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
          trailing: Text(song.ranking.toString()),
          onTap: () => BlocProvider.of<PlaybackBloc>(context).add(
            PlaybackEvent.changeSong(song),
          ),
        );
      },
      columns: const [
        DataColumn(
          label: Text('Ranking'),
        ),
        DataColumn(
          label: Text('Title'),
        ),
        DataColumn(
          label: Text('Length'),
        ),
      ],
      rowBuilder: (song, index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            HoverableSongPlayButton(
              song: song,
              child: Center(
                child: Text(song.ranking.toString()),
              ),
            ),
          ),
          DataCell(
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClippedImage(song.image.image),
                )
              ],
            ),
          ),
          DataCell(
            Text(song.length.toHumanizedString()),
          ),
        ],
      ),
    );
  }
}
