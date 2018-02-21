import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app_state.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/ui/theater_list/theater_list_view_model.dart';

class TheaterList extends StatelessWidget {
  TheaterList(this.header);
  final Widget header;

  Widget _buildTheatersSubhead(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        new Row(
          children: [
            new Expanded(
              child: new Container(
                color: Theme.of(context).canvasColor,
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  bottom: 16.0,
                ),
                child: new Text(
                  'Theaters',
                  style: new TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Align(
          alignment: Alignment.topCenter,
          child: new Container(
            height: 300.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        new StoreConnector<AppState, TheaterListViewModel>(
          distinct: true,
          converter: (store) => TheaterListViewModel.fromStore(store),
          builder: (BuildContext context, TheaterListViewModel viewModel) {
            return new ListView.builder(
              itemCount: viewModel.theaters.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _buildTheatersSubhead(context);
                }

                var theater = viewModel.theaters[index - 1];
                var isSelected = viewModel.currentTheater.id == theater.id;

                return new Material(
                  color: isSelected
                      ? const Color(0xFFEEEEEE)
                      : Theme.of(context).canvasColor,
                  child: new ListTile(
                    onTap: () => viewModel.changeCurrentTheater(theater),
                    selected: isSelected,
                    title: new Text(theater.name),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
