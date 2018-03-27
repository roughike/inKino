import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/ui/error_view.dart';
import 'package:inkino/ui/loading_view.dart';
import 'package:inkino/ui/showtimes/showtime_date_selector.dart';
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';

class ShowtimesPage extends StatelessWidget {
  Widget _buildShowtimeList(ShowtimesPageViewModel viewModel) {
    if (viewModel.shows.isEmpty) {
      return new InfoMessageWidget(
        title: 'All empty!',
        description: 'Didn\'t find any movies\nabout to start for today. ¯\\_(ツ)_/¯',
        onActionButtonTapped: viewModel.refreshShowtimes,
      );
    }

    return new Scrollbar(
      child: new ListView.builder(
        padding: const EdgeInsets.only(bottom: 8.0),
        itemCount: viewModel.shows.length,
        itemBuilder: (BuildContext context, int index) {
          var show = viewModel.shows[index];
          var useAlternateBackground = index % 2 == 0;

          return new Column(
            children: <Widget>[
              new ShowtimeListTile(show, useAlternateBackground),
              new Divider(
                height: 1.0,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ShowtimesPageViewModel>(
      converter: (store) => ShowtimesPageViewModel.fromStore(store),
      builder: (BuildContext context, ShowtimesPageViewModel viewModel) {
        return new Column(
          children: <Widget>[
            new Expanded(
              child: new LoadingView(
                status: viewModel.status,
                loadingContent: new CircularProgressIndicator(),
                errorContent: new ErrorView(
                  onRetry: viewModel.refreshShowtimes,
                ),
                successContent: _buildShowtimeList(viewModel),
              ),
            ),
            new ShowtimeDateSelector(viewModel),
          ],
        );
      },
    );
  }
}
