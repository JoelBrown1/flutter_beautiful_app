import 'package:flutter/material.dart';
import 'package:flutter_beautiful_app/src/shared/views/clickable.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../shared/classes/artist.dart';

import '../../../shared/providers/theme.dart';

import '../../../shared/views/adaptive_table.dart';

class ArtistEvent extends StatelessWidget {
  const ArtistEvent({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    final colors = Theme.of(context).colorScheme;

    return AdaptiveTable(
      breakpoint: 720,
      items: artist.events,
      itemBuilder: (item, index) {
        final dateParts = item.date.split('/');
        return ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: dateParts[0],
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    TextSpan(
                      text: '/',
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    TextSpan(
                      text: dateParts[1],
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          title: Text(item.title),
          subtitle: Text(item.location),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.info_outline),
          ),
        );
      },
      columns: const <DataColumn>[
        DataColumn(
          label: Text('date'),
          numeric: true,
        ),
        DataColumn(
          label: Text('event'),
        ),
        DataColumn(
          label: Text('location'),
        ),
        DataColumn(
          label: Text('more info'),
        ),
      ],
      rowBuilder: (item, index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            Text(item.date),
          ),
          DataCell(
            Text(item.title),
          ),
          DataCell(
            Text(item.location),
          ),
          DataCell(
            Clickable(
              child: Text(
                item.link,
                style: TextStyle(
                  color: linkColor.value(theme),
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => launchUrl(
                Uri.parse('https://docs.flutter.dev'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
