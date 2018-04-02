import 'package:flutter/material.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';
import 'package:intl/intl.dart';

class ShowtimeDateSelector extends StatelessWidget {
  ShowtimeDateSelector(this.viewModel);
  final ShowtimesPageViewModel viewModel;

  Widget _buildDateItem(DateTime date) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: new Text(
                  new DateFormat('E').format(date),
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ),
              new Text(
                date.day.toString(),
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
      height: 56.0 + MediaQuery.of(context).padding.bottom,
      color: const Color(0xFF222222),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.dates.length,
        itemBuilder: (BuildContext context, int index) {
          var date = viewModel.dates[index];
          return _buildDateItem(date);
        },
      ),
    );
  }
}
