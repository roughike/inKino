import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/message_provider.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:inkino/ui/events/event_grid.dart';

class EventsPage extends StatelessWidget {
  EventsPage(this.listType);
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EventsPageViewModel>(
      distinct: true,
      onInit: (store) => store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) => EventsPageViewModel.fromStore(store, listType),
      builder: (_, viewModel) => EventsPageContent(viewModel, listType),
    );
  }
}

class EventsPageContent extends StatelessWidget {
  EventsPageContent(this.viewModel, this.listType);
  final EventsPageViewModel viewModel;
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    return LoadingView(
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: messages.errorLoadingEvents,
        onRetry: viewModel.refreshEvents,
      ),
      successContent: EventGrid(
        listType: listType,
        events: viewModel.events,
        onReloadCallback: viewModel.refreshEvents,
      ),
    );
  }
}
