import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './playlist_songs.dart';

import '../../../shared/classes/playlist.dart';
import '../../../shared/extensions.dart';
import '../../../shared/views/adaptive_image_card.dart';
import '../../../shared/views/article_content.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key, required this.playlist});

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final colors = Theme.of(context).colorScheme;
      final double headerHeight = constraints.isMobile
          ? max(constraints.biggest.height * .5, 450)
          : max(constraints.biggest.height * .25, 250);

      if (constraints.isMobile) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => GoRouter.of(context).go('/playlists'),
            ),
            title: Text(playlist.title),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_circle_fill),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shuffle),
              ),
            ],
          ),
          body: ArticleContent(
              child: PlaylistSongs(
            playlist: playlist,
            constraints: constraints,
          )),
        );
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/playlists'),
              ),
              expandedHeight: headerHeight,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: AdaptiveImageCard(
                  axis: constraints.isMobile ? Axis.vertical : Axis.horizontal,
                  constraints:
                      constraints.copyWith(maxHeight: headerHeight).normalize(),
                  image: playlist.cover.image,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Playlist',
                        style: context.titleSmall!
                            .copyWith(color: colors.onSurface),
                      ),
                      Text(
                        playlist.title,
                        style: context.displaySmall!
                            .copyWith(color: colors.onSurface),
                      ),
                      Text(
                        playlist.description,
                        style: context.bodyLarge!
                            .copyWith(color: colors.onSurface.withOpacity(.8)),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_circle_fill,
                              color: colors.tertiary,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shuffle,
                              color: colors.tertiary,
                            ),
                            label: Text(
                              'Shuffle',
                              style: context.bodySmall!
                                  .copyWith(color: colors.tertiary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
