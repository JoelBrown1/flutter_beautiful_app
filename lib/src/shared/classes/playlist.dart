import 'package:flutter_beautiful_app/src/shared/classes/image.dart';
import '../classes/song.dart';

class Playlist {
  Playlist(
      {required this.id,
      required this.title,
      required this.description,
      required this.songs,
      this.cover = const MyArtistImage(
        image: 'assets/images/record.jpeg',
        sourceName: 'Adobe Stock images',
        sourceLink: '',
      )});

  final String id;
  final String title;
  final String description;
  final List<Song> songs;
  MyArtistImage cover;
}
