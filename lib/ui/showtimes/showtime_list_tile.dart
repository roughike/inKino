import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_selectors.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:intl/intl.dart';

class ShowtimeListTile extends StatelessWidget {
  static final DateFormat hoursAndMins = DateFormat('HH:mm');

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
      MaterialPageRoute(
        builder: (_) => EventDetailsPage(event, show: show),
      ),
    );
  }

  Widget _buildShowtimesInfo() {
    return Column(
      children: <Widget>[
        Text(
          hoursAndMins.format(show.start),
          style: const TextStyle(fontSize: 20.0),
        ),
        Text(
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
    var presentationMethodInfo = Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: Text(
        show.presentationMethod,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            show.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(show.theaterAndAuditorium),
          presentationMethodInfo,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        useAlternateBackground ? const Color(0xFFF5F5F5) : Colors.white;

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: () => _navigateToEventDetails(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: <Widget>[
              _buildShowtimesInfo(),
              const SizedBox(width: 20.0),
              _buildDetailedInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
