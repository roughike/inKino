import 'package:flutter/material.dart';
import 'package:inkino/models/show.dart';
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
  static const Key ticketsButtonKey = const Key('ticketsButton');
  static final weekdayFormat = DateFormat("E 'at' hh:mma");

  ShowtimeInformation(this.show);
  final Show show;

  Widget _buildTimeAndTheaterInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          weekdayFormat.format(show.start),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          show.theaterAndAuditorium,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.schedule,
                color: Colors.black87,
              ),
              const SizedBox(width: 8.0),
              _buildTimeAndTheaterInformation(),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        RaisedButton(
          key: ticketsButtonKey,
          onPressed: () => launchTicketsUrl(show.url),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: const Text('Tickets'),
        ),
      ],
    );
  }
}
