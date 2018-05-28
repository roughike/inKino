import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/ui/theater_list/theater_list_view_model.dart';
import 'package:meta/meta.dart';

class TheaterList extends StatelessWidget {
  TheaterList({
    @required this.header,
    @required this.onTheaterTapped,
  });

  final Widget header;
  final VoidCallback onTheaterTapped;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.vertical;

    return Transform(
      // FIXME: A hack for drawing behind the status bar, find a proper solution.
      transform: Matrix4.translationValues(0.0, -statusBarHeight, 0.0),
      child: StoreConnector<AppState, TheaterListViewModel>(
        distinct: true,
        converter: (store) => TheaterListViewModel.fromStore(store),
        builder: (BuildContext context, TheaterListViewModel viewModel) {
          return TheaterListContent(
            header: header,
            onTheaterTapped: onTheaterTapped,
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class TheaterListContent extends StatelessWidget {
  TheaterListContent({
    @required this.header,
    @required this.onTheaterTapped,
    @required this.viewModel,
  });

  final Widget header;
  final VoidCallback onTheaterTapped;
  final TheaterListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.theaters.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return header;
        }

        var theater = viewModel.theaters[index - 1];
        var isSelected = viewModel.currentTheater.id == theater.id;
        var backgroundColor = isSelected
            ? const Color(0xFFEEEEEE)
            : Theme.of(context).canvasColor;

        return Material(
          color: backgroundColor,
          child: ListTile(
            onTap: () {
              viewModel.changeCurrentTheater(theater);
              onTheaterTapped();
            },
            selected: isSelected,
            title: Text(theater.name),
          ),
        );
      },
    );
  }
}
