import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_selectors.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:intl/intl.dart';

class ShowtimeListTile extends StatelessWidget {
  static final DateFormat hoursAndMins = new DateFormat('HH:mm');

  ShowtimeListTile(
    this.show,
    this.useAlternateBackground,
  );

  final Show show;
  final bool useAlternateBackground;

  void _navigateToEventDetails(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var event = eventForShowSelector(store.state, show);

    Navigator.push<Null>(
      context,
      new MaterialPageRoute(
        builder: (_) => new EventDetailsPage(event, show: show),
      ),
    );
  }

  Widget _buildShowtimesInfo() {
    return new Column(
      children: <Widget>[
        new Text(
          hoursAndMins.format(show.start),
          style: const TextStyle(fontSize: 20.0),
        ),
        new Text(
          hoursAndMins.format(show.end),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedInfo() {
    var presentationMethodInfo = new Container(
      decoration: new BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: new BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: new Text(
        show.presentationMethod,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );

    return new Expanded(
      child: new Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              show.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: new Text(show.theaterAndAuditorium),
            ),
            presentationMethodInfo,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        useAlternateBackground ? const Color(0xFFF5F5F5) : Colors.white;

    return new Material(
      color: backgroundColor,
      child: new InkWell(
        onTap: () => _navigateToEventDetails(context),
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: new Row(
            children: <Widget>[
              _buildShowtimesInfo(),
              _buildDetailedInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
