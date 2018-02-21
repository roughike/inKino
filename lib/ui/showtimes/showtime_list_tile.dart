import 'package:flutter/material.dart';
import 'package:inkino/data/show.dart';
import 'package:intl/intl.dart';

class ShowtimeListTile extends StatelessWidget {
  static final DateFormat hoursAndMins = new DateFormat('HH:mm');

  ShowtimeListTile(
    this.show,
    this.useAlternateBackground,
  );

  final Show show;
  final bool useAlternateBackground;

  Widget _buildShowtimesInfo() {
    return new Column(
      children: [
        new Text(
          hoursAndMins.format(show.start),
          style: new TextStyle(fontSize: 20.0),
        ),
        new Text(
          hoursAndMins.format(show.end),
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedInfo() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          show.title,
          style: new TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Text(show.theaterAndAuditorium),
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 2.0),
          child: new Text(
            show.presentationMethod,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = useAlternateBackground
        ? Colors.black.withOpacity(0.01)
        : Colors.white;

    return new Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: new Row(
        children: <Widget>[
          _buildShowtimesInfo(),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: _buildDetailedInfo(),
            ),
          ),
        ],
      ),
    );
  }
}
