import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:inkino/ui/showtimes/showtime_date_selector.dart';
import 'package:inkino/ui/showtimes/showtime_list.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';

class ShowtimesPage extends StatelessWidget {
  const ShowtimesPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ShowtimesPageViewModel>(
      distinct: true,
      converter: (store) => ShowtimesPageViewModel.fromStore(store),
      builder: (_, viewModel) => ShowtimesPageContent(viewModel),
    );
  }
}

class ShowtimesPageContent extends StatelessWidget {
  ShowtimesPageContent(this.viewModel);
  final ShowtimesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: LoadingView(
            status: viewModel.status,
            loadingContent: const PlatformAdaptiveProgressIndicator(),
            errorContent: ErrorView(onRetry: viewModel.refreshShowtimes),
            successContent: ShowtimeList(viewModel.shows),
          ),
        ),
        ShowtimeDateSelector(viewModel),
      ],
    );
  }
}
