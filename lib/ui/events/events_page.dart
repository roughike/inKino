import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/redux/app/app_state.dart';
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
    return StoreConnector<AppState, EventsPageViewModel>(
      distinct: true,
      converter: (store) => EventsPageViewModel.fromStore(store, listType),
      builder: (_, viewModel) => EventsPageContent(viewModel),
    );
  }
}

class EventsPageContent extends StatelessWidget {
  EventsPageContent(this.viewModel);
  final EventsPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Error loading events.',
        onRetry: viewModel.refreshEvents,
      ),
      successContent: EventGrid(
        events: viewModel.events,
        onReloadCallback: viewModel.refreshEvents,
      ),
    );
  }
}
