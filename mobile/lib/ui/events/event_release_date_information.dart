import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/message_provider.dart';
import 'package:intl/intl.dart';

class EventReleaseDateInformation extends StatelessWidget {
  static final _releaseDateFormat = DateFormat('dd.MM.yyyy');

  EventReleaseDateInformation(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.only(
        top: 5.0,
        right: 20.0,
        bottom: 5.0,
        left: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            messages.releaseDate,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            _releaseDateFormat.format(event.releaseDate),
            style: const TextStyle(
              color: const Color(0xFFFEFEFE),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
