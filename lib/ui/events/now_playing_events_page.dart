import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';

class NowPlayingEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (store) =>
          EventsPageViewModel.fromStore(store, EventListType.nowInTheaters),
      builder: (BuildContext context, EventsPageViewModel viewModel) {
        return new EventGrid(viewModel.events);
      },
    );
  }
}
