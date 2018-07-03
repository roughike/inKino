import 'package:flutter/material.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:inkino/ui/events/event_grid_item.dart';
import 'package:meta/meta.dart';

class EventGrid extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  EventGrid({
    @required this.events,
    @required this.onReloadCallback,
  });

  final List<Event> events;
  final VoidCallback onReloadCallback;

  void _openEventDetails(BuildContext context, Event event) {
    Navigator.push<Null>(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailsPage(event),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var crossAxisChildCount = isPortrait ? 2 : 4;

    return Container(
      key: contentKey,
      color: const Color(0xFF222222),
      child: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisChildCount,
            childAspectRatio: 2 / 3,
          ),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            var event = events[index];
            return EventGridItem(
              event: event,
              onTapped: () => _openEventDetails(context, event),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description: 'Didn\'t find any movies at\nall. ¯\\_(ツ)_/¯',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
