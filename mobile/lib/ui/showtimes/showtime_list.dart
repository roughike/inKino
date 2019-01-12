import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/message_provider.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';
import 'package:kt_dart/collection.dart';

class ShowtimeList extends StatefulWidget {
  static const Key emptyViewKey = Key('emptyView');
  static const Key contentKey = Key('content');

  ShowtimeList(this.status, this.shows);
  final LoadingStatus status;
  final KtList<Show> shows;

  @override
  _ShowtimeListState createState() => _ShowtimeListState();
}

class _ShowtimeListState extends State<ShowtimeList> {
  KtList<Show> _shows = emptyList();
  bool _showEmptyView = false;

  @override
  void initState() {
    super.initState();
    _shows = widget.shows;
    _showEmptyView = _shows.isEmpty() && widget.status == LoadingStatus.success;
  }

  @override
  void didUpdateWidget(ShowtimeList oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// We do this dance here since we want to "freeze" the content until
    /// the [LoadingView] hides us completely.
    if (oldWidget.status != widget.status) {
      /// Loading status changed and shows got updated; update them after the
      /// animation finishes.
      if (widget.status == LoadingStatus.success) {
        Timer(
          LoadingView.successContentAnimationDuration,
          () => _shows = widget.shows,
        );
      }
    } else if (widget.status == LoadingStatus.success) {
      /// Loading status didn't change, so update the shows instantly.
      _shows = widget.shows;
    }

    _showEmptyView =
        widget.shows.isEmpty() && widget.status == LoadingStatus.success;
  }

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    if (_showEmptyView) {
      return InfoMessageView(
        key: ShowtimeList.emptyViewKey,
        title: messages.allEmpty,
        description: messages.noMoviesForToday,
      );
    }

    return Scrollbar(
      key: ShowtimeList.contentKey,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50.0),
        itemCount: _shows.size,
        itemBuilder: (BuildContext context, int index) {
          final show = _shows[index];
          return ShowtimeListTile(show);
        },
      ),
    );
  }
}
