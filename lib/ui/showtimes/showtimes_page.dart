import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/showtimes/showtime_date_selector.dart';
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';

class ShowtimesPage extends StatelessWidget {
  static final Key emptyViewKey = new Key('emptyView');
  static final Key contentKey = new Key('content');

  ShowtimesPage(this.viewModel);
  final ShowtimesPageViewModel viewModel;

  Widget _buildShowtimeList(ShowtimesPageViewModel viewModel) {
    if (viewModel.shows.isEmpty) {
      return new InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description:
            'Didn\'t find any movies\nabout to start for today. ¯\\_(ツ)_/¯',
      );
    }

    return new Scrollbar(
      key: contentKey,
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
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new LoadingView(
            status: viewModel.status,
            loadingContent: Platform.isIOS
                ? new CupertinoActivityIndicator()
                : new CircularProgressIndicator(),
            errorContent: new ErrorView(onRetry: viewModel.refreshShowtimes),
            successContent: _buildShowtimeList(viewModel),
          ),
        ),
        new ShowtimeDateSelector(viewModel),
      ],
    );
  }
}
