import 'package:flutter/material.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';

class ShowtimeList extends StatelessWidget {
  static const Key emptyViewKey = Key('emptyView');
  static const Key contentKey = Key('content');

  ShowtimeList(this.shows);
  final List<Show> shows;

  @override
  Widget build(BuildContext context) {
    if (shows.isEmpty) {
      return const InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description:
            'Didn\'t find any movies\nabout to start for today. ¯\\_(ツ)_/¯',
      );
    }

    return Scrollbar(
      key: contentKey,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 8.0),
        itemCount: shows.length,
        itemBuilder: (BuildContext context, int index) {
          var show = shows[index];
          var useAlternateBackground = index % 2 == 0;

          return Column(
            children: <Widget>[
              ShowtimeListTile(show, useAlternateBackground),
              const Divider(
                height: 1.0,
                color: const Color(0x40000000),
              ),
            ],
          );
        },
      ),
    );
  }
}
