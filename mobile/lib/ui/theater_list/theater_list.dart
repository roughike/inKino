import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';

class TheaterList extends StatelessWidget {
  TheaterList({
    @required this.onTheaterTapped,
  });

  final VoidCallback onTheaterTapped;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TheaterListViewModel>(
      distinct: true,
      converter: (store) => TheaterListViewModel.fromStore(store),
      builder: (BuildContext context, TheaterListViewModel viewModel) {
        return TheaterListContent(
          onTheaterTapped: onTheaterTapped,
          viewModel: viewModel,
        );
      },
    );
  }
}

class TheaterListContent extends StatelessWidget {
  TheaterListContent({
    @required this.onTheaterTapped,
    @required this.viewModel,
  });

  final VoidCallback onTheaterTapped;
  final TheaterListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: viewModel.theaters.size,
        itemBuilder: (BuildContext context, int index) {
          final theater = viewModel.theaters[index];
          final isSelected = viewModel.currentTheater.id == theater.id;
          final backgroundColor =
              isSelected ? Colors.black54 : Colors.transparent;
          final foregroundColor =
              isSelected ? Colors.white : Colors.white.withOpacity(0.56);

          return Material(
            color: backgroundColor,
            child: ListTile(
              onTap: () {
                viewModel.changeCurrentTheater(theater);
                onTheaterTapped();
              },
              selected: isSelected,
              title: Text(
                theater.name,
                style: TextStyle(color: foregroundColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
