import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';

class EventsPage extends StatelessWidget {
  EventsPage(this.listType);
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (store) => EventsPageViewModel.fromStore(store, listType),
      builder: (_, viewModel) => new EventsPageContent(viewModel),
    );
  }
}

class EventsPageContent extends StatelessWidget {
  EventsPageContent(this.viewModel);
  final EventsPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return new LoadingView(
      status: viewModel.status,
      loadingContent: new PlatformAdaptiveProgressIndicator(),
      errorContent: new ErrorView(
        description: 'Error loading events.',
        onRetry: viewModel.refreshEvents,
      ),
      successContent: new EventGrid(
        events: viewModel.events,
        onReloadCallback: viewModel.refreshEvents,
      ),
    );
  }
}
