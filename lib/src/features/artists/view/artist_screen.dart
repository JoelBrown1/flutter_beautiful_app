import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/extensions.dart';

import './artist_ranked_song.dart';
import './artist_event.dart';
import './artist_news.dart';

import '../../../shared/classes/artist.dart';
import '../../../shared/views/article_content.dart';
import '../../../shared/views/image_clipper.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final colors = Theme.of(context).colorScheme;
        double headerHeight = constraints.maxWidth > 500 ? 300 : 400;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/artists'),
              ),
              title: Text('Artist - ${artist.name}'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight + headerHeight),
                child: Column(
                  children: [
                    ArticleContent(
                      child: Builder(
                        builder: (context) {
                          if (constraints.maxWidth > 500) {
                            return SizedBox(
                              height: headerHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClippedImage(
                                    artist.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        artist.bio,
                                        style: context.bodyLarge!.copyWith(
                                          color: colors.onSurface,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox(
                            height: headerHeight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: ClippedImage(
                                    artist.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      artist.bio,
                                      style: context.bodyLarge!.copyWith(
                                        color: colors.onSurface,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const TabBar(tabs: [
                      Tab(
                        text: 'songs',
                      ),
                      Tab(
                        text: 'events',
                      ),
                      Tab(
                        text: 'news',
                      ),
                    ])
                  ],
                ),
              ),
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: ArtistRankedSongs(artist: artist),
              ),
              SingleChildScrollView(
                child: ArtistEvent(artist: artist),
              ),
              SingleChildScrollView(
                child: ArtistNews(artist: artist),
              ),
            ]),
          ),
        );
      },
    );
  }
}
