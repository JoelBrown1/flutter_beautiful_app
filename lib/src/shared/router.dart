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
  )
]);

const List<NavigationDestination> destinations = [
  // home
  NavigationDestination(
    icon: Icon(Icons.arrow_right_alt_rounded),
    label: 'home',
    route: '/',
  ),
  NavigationDestination(
    icon: Icon(Icons.arrow_right_rounded),
    label: 'Playlists',
    route: '/playlists',
  ),
  NavigationDestination(
    icon: Icon(Icons.arrow_right_rounded),
    label: 'Artists',
    route: '/artists',
  ),
];
