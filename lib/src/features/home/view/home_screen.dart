import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';

// classes
import '../../../shared/classes/artist.dart';
import '../../../shared/classes/playlist.dart';

// extensions
import '../../../shared/extensions.dart';

// providers
import '../../../shared/providers/artists.dart';
import '../../../shared/providers/playlists.dart';

// views
import '../../../shared/views/brightnessToggle.dart';
import './home_highlight.dart';
import './home_artists.dart';
import './home_recent.dart';

import '../../playlists/view/playlist_songs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final PlaylistsProvider playListProvider = PlaylistsProvider();
    final List<Playlist> playlists = playListProvider.playlists;
    final Playlist topSongs = playListProvider.topSongs;
    final Playlist newReleases = playListProvider.newReleases;
    final ArtistsProvider artistProvider = ArtistsProvider();
    final List<Artist> artists = artistProvider.artists;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: AdaptiveColumn(
              children: [
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'good morning',
                            style: context.displaySmall,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const BrightnessToggle(),
                      ],
                    ),
                  ),
                ),
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Column(
                    children: [
                      const HomeHighlight(),
                      LayoutBuilder(
                        builder: (context, constraints) => HomeArtists(
                          artists: artists,
                          constraints: constraints,
                        ),
                      ),
                    ],
                  ),
                ),
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2), // Modify this line
                        child: Text(
                          'Recently played',
                          style: context.headlineSmall,
                        ),
                      ),
                      HomeRecent(
                        playlists: playlists,
                      ),
                    ],
                  ),
                ),
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(2), // Modify this line
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(2), // Modify this line
                                child: Text(
                                  'Top Songs Today',
                                  style: context.titleLarge,
                                ),
                              ),
                              LayoutBuilder(
                                builder: (context, constraints) =>
                                    PlaylistSongs(
                                  playlist: topSongs,
                                  constraints: constraints,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add spacer between tables
                        Flexible(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(2), // Modify this line
                                child: Text(
                                  'New Releases',
                                  style: context.titleLarge,
                                ),
                              ),
                              LayoutBuilder(
                                builder: (context, constraints) =>
                                    PlaylistSongs(
                                  playlist: newReleases,
                                  constraints: constraints,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
