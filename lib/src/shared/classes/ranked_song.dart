import './song.dart';
import './image.dart';
import 'artist.dart';

class RankedSong extends Song {
  final int ranking;

  const RankedSong(
    this.ranking,
    String title,
    Artist artist,
    Duration length,
    MyArtistImage image,
  ) : super(title, artist, length, image);
}
