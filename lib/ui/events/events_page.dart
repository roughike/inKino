import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/ui/error_view.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';
import 'package:inkino/ui/loading_view.dart';

class EventsPage extends StatelessWidget {
  EventsPage(this.listType);
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (store) => EventsPageViewModel.fromStore(store, listType),
      builder: (BuildContext context, EventsPageViewModel viewModel) {
        return new LoadingView(
          status: viewModel.status,
          loadingContent: new CircularProgressIndicator(),
          errorContent: new ErrorView(
            description: 'Error loading events.',
            onRetry: viewModel.refreshEvents,
          ),
          successContent: new EventGrid(viewModel.events),
        );
      },
    );
  }
}
