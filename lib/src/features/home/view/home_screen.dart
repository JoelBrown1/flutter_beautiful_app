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
        if (constraints.isMobile) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: const Text('Good Morning'),
                actions: const [BrightnessToggle()],
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Home'),
                    Tab(text: 'Recently Played'),
                    Tab(text: 'New Releases'),
                    Tab(text: 'Top Songs'),
                  ],
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) => TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const HomeHighlight(),
                          HomeArtists(
                              artists: artists, constraints: constraints),
                        ],
                      ),
                    ),
                    HomeRecent(
                      playlists: playlists,
                      axis: Axis.vertical,
                    ),
                    PlaylistSongs(playlist: topSongs, constraints: constraints),
                    PlaylistSongs(
                        playlist: newReleases, constraints: constraints),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: AdaptiveColumn(
              children: [
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10), // Modify this line
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
                    padding: const EdgeInsets.all(15), // Modify this line
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
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 8,
                                ), // Modify this line
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
                        const SizedBox(width: 15),
                        // Add spacer between tables
                        Flexible(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 8,
                                ), // Modify this line
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
