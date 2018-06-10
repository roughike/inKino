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

    var content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Text(
          DateFormat('E').format(date),
          style: TextStyle(
            fontSize: 12.0,
            color: color,
          ),
        ),
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => viewModel.changeCurrentDate(date),
        radius: 56.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0 + MediaQuery.of(context).padding.bottom,
      color: const Color(0xFF222222),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                viewModel.dates.map((date) => _buildDateItem(date)).toList(),
          ),
        ),
      ),
    );
  }
}
