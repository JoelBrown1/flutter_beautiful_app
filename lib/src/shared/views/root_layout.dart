import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' as go;
import 'package:universal_platform/universal_platform.dart';

import '../playback/bloc/playback_bloc.dart';
// import '../playback/bloc/playback_state.dart';

import '../router.dart' as router;

// required views specifically
import '../views/adaptive_navigation.dart';
import '../views/bottom_bar.dart';

class _Switcher extends StatelessWidget {
  const _Switcher({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isDesktop
        ? child
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            key: key,
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: child,
          );
  }
}

class RootLayout extends StatelessWidget {
  const RootLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  final Widget child;
  final int currentIndex;
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    return BlocBuilder<PlaybackBloc, PlaybackState>(
      bloc: bloc,
      builder: (context, state) => LayoutBuilder(builder: (context, dimens) {
        void onSelected(int index) {
          print('what was selected: ${index}');
          final destination = router.destinations[index];
          go.GoRouter.of(context).go(destination.route);
        }

        final current = state.songWithProgress;
        return AdaptiveNavigation(
          key: _navigationRailKey,
          destinations: router.destinations
              .map(
                (route) => NavigationDestination(
                  icon: route.icon,
                  label: route.label,
                ),
              )
              .toList(),
          selectedIndex: currentIndex,
          onDestinationSelected: onSelected,
          child: Column(
            children: [
              Expanded(
                child: _Switcher(
                  key: _switcherKey,
                  child: child,
                ),
              ),
              if (current != null) const BottomBar(),
            ],
          ),
        );
      }),
    );
  }
}
