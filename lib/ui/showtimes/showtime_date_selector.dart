import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/data/schedule_date.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';

class ShowtimeDateSelector extends StatelessWidget {
  Widget _buildDateItem(ScheduleDate date, ShowtimesPageViewModel viewModel) {
    var color = date == viewModel.selectedDate
        ? Colors.white
        : Colors.white.withOpacity(0.4);

    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () => viewModel.changeCurrentDate(date),
        radius: 56.0,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Sun',
                style: new TextStyle(
                  fontSize: 12.0,
                  color: color,
                ),
              ),
              new Text(
                '11',
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      color: const Color(0xFF222222),
      child: new StoreConnector<AppState, ShowtimesPageViewModel>(
        converter: (store) => ShowtimesPageViewModel.fromStore(store),
        builder: (BuildContext context, ShowtimesPageViewModel viewModel) {
          return new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.availableDates.length,
            itemBuilder: (BuildContext context, int index) {
              var date = viewModel.availableDates[index];
              return _buildDateItem(date, viewModel);
            },
          );
        },
      ),
    );
  }
}
