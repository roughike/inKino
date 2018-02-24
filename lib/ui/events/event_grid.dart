import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/ui/events/event_grid_item.dart';

class EventGrid extends StatelessWidget {
  EventGrid(this.events);
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        var event = events[index];
        return new EventGridItem(event);
      },
    );
  }
}
