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
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ShowtimesPageViewModel>(
      distinct: true,
      converter: (store) => ShowtimesPageViewModel.fromStore(store),
      builder: (_, viewModel) => new ShowtimesPageContent(viewModel),
    );
  }
}

class ShowtimesPageContent extends StatelessWidget {
  ShowtimesPageContent(this.viewModel);
  final ShowtimesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new LoadingView(
            status: viewModel.status,
            loadingContent: new PlatformAdaptiveProgressIndicator(),
            errorContent: new ErrorView(onRetry: viewModel.refreshShowtimes),
            successContent: new ShowtimeList(viewModel.shows),
          ),
        ),
        new ShowtimeDateSelector(viewModel),
      ],
    );
  }
}
