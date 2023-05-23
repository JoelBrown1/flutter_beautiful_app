import 'package:flutter/material.dart';
import 'package:flutter_beautiful_app/src/shared/views/clickable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/classes/artist.dart';
import '../../../shared/views/image_card.dart';

class ArtistNews extends StatelessWidget {
  const ArtistNews({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final article in artist.news)
          Clickable(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ImageCard(
                title: article.title,
                subtitle: article.author,
                details: article.blurb,
                image: article.image.image.toString(),
              ),
            ),
            onTap: () {
              launchUrl(Uri.parse('httpe://docs.flutter.dev'));
            },
          )
      ],
    );
  }
}
