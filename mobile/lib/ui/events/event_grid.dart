import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/message_provider.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:inkino/ui/events/event_grid_item.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

class EventGrid extends StatelessWidget {
  static const emptyViewKey = const Key('emptyView');
  static const contentKey = const Key('content');

  EventGrid({
    @required this.listType,
    @required this.events,
    @required this.onReloadCallback,
  });

  final EventListType listType;
  final KtList<Event> events;
  final VoidCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    if (events.isEmpty()) {
      return InfoMessageView(
        key: emptyViewKey,
        title: messages.allEmpty,
        description: messages.noMovies,
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _Content(events, listType);
  }
}

class _Content extends StatelessWidget {
  _Content(this.events, this.listType);
  final KtList<Event> events;
  final EventListType listType;

  void _openEventDetails(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailsPage(event),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final event = events[index];

    return EventGridItem(
      event: event,
      onTapped: () => _openEventDetails(context, event),
      showReleaseDateInformation: listType == EventListType.comingSoon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final crossAxisChildCount = isPortrait ? 2 : 4;

    return Container(
      key: EventGrid.contentKey,
      child: Scrollbar(
        child: GridView.builder(
          padding: const EdgeInsets.only(bottom: 50.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisChildCount,
            childAspectRatio: 2 / 3,
          ),
          itemCount: events.size,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }
}
