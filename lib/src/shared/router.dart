import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Providers
import './providers/artists.dart';
import './providers/playlists.dart';

// views
import './views/root_layout.dart';

// features/views
import '../features/home/view/home_screen.dart';
import '../features/playlists/view/playlist_home_screen.dart';
import '../features/playlists/view/playlist_screen.dart';
import '../features/artists/view/artists_screen.dart';
import '../features/artists/view/artist_screen.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

final artistsProvider = ArtistsProvider();
final playlistsProvider = PlaylistsProvider();

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(routes: [
  //home screen
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => const MaterialPage<void>(
      key: _pageKey,
      child: RootLayout(
        key: _scaffoldKey,
        currentIndex: 0,
        child: HomeScreen(),
      ),
    ),
  ),
  GoRoute(
    path: '/playlists',
    pageBuilder: (context, state) => const MaterialPage<void>(
      key: _pageKey,
      child: RootLayout(
        key: _scaffoldKey,
        currentIndex: 1,
        child: PlaylistHomeScreen(),
      ),
    ),
    routes: [
      GoRoute(
        path: ':pid',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: 1,
            child: PlaylistScreen(
              playlist:
                  playlistsProvider.getPlaylist(state.pathParameters['pid']!)!,
            ),
          ),
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/artists',
    pageBuilder: (context, state) => const MaterialPage<void>(
      key: _pageKey,
      child: RootLayout(
        child: ArtistsScreen(),
        currentIndex: 2,
      ),
    ),
    routes: [
      GoRoute(
        path: ':pid',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: 2,
            child: ArtistScreen(
              artist: artistsProvider.getArtist(state.pathParameters['pid']!)!,
            ),
          ),
        ),
      ),
    ],
  ),
  for (final route in destinations.skip(3))
    GoRoute(
      path: route.route,
      pageBuilder: (context, state) => MaterialPage(
        key: _pageKey,
        child: RootLayout(
          child: const SizedBox(),
          currentIndex: destinations.indexOf(route),
          key: _scaffoldKey,
        ),
      ),
    ),
]);

const List<NavigationDestination> destinations = [
  // home
  NavigationDestination(
    icon: Icon(Icons.home),
    label: 'home',
    route: '/',
  ),
  NavigationDestination(
    icon: Icon(Icons.playlist_add_check),
    label: 'Playlists',
    route: '/playlists',
  ),
  NavigationDestination(
    icon: Icon(Icons.people),
    label: 'Artists',
    route: '/artists',
  ),
];
