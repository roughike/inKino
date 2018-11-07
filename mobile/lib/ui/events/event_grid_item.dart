import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/ui/events/event_poster.dart';
import 'package:inkino/ui/events/event_release_date_information.dart';
import 'package:meta/meta.dart';

class EventGridItem extends StatelessWidget {
  EventGridItem({
    @required this.event,
    @required this.onTapped,
    @required this.showReleaseDateInformation,
  });

  final Event event;
  final VoidCallback onTapped;
  final bool showReleaseDateInformation;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Stack(
        fit: StackFit.expand,
        children: [
          EventPoster(event: event),
          _TextualInfo(event),
          Positioned(
            top: 10.0,
            child: Visibility(
              visible: showReleaseDateInformation,
              child: EventReleaseDateInformation(event),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapped,
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextualInfo extends StatelessWidget {
  _TextualInfo(this.event);
  final Event event;

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0, 0.7, 0.7],
        colors: [
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildGradientBackground(),
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: _TextualInfoContent(event),
    );
  }
}

class _TextualInfoContent extends StatelessWidget {
  _TextualInfoContent(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          event.genres,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
