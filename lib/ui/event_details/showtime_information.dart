import 'package:flutter/material.dart';
import 'package:inkino/data/models/show.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

@visibleForTesting
Function(String) launchTicketsUrl = (url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
};

class ShowtimeInformation extends StatelessWidget {
  static final Key ticketsButtonKey = new Key('ticketsButton');
  static final weekdayFormat = new DateFormat("E 'at' hh:mma");

  ShowtimeInformation(this.show);
  final Show show;

  Widget _buildTimeAndTheaterInformation() {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            weekdayFormat.format(show.start),
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          new Text(
            show.theaterAndAuditorium,
            style: new TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          child: new Row(
            children: <Widget>[
              new Icon(
                Icons.schedule,
                color: Colors.black87,
              ),
              _buildTimeAndTheaterInformation(),
            ],
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new RaisedButton(
            key: ticketsButtonKey,
            onPressed: () => launchTicketsUrl(show.url),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: new Text('Tickets'),
          ),
        ),
      ],
    );
  }
}
