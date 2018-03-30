import 'package:flutter/material.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/ui/event_details/actor_scroller.dart';
import 'package:inkino/ui/event_details/event_header.dart';
import 'package:inkino/ui/event_details/storyline_widget.dart';
import 'package:inkino/ui/events/event_poster.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatelessWidget {
  static final weekdayFormat = new DateFormat("E 'at' hh:mma");

  EventDetailsPage(
    this.event, {
    this.show,
  });

  final Event event;
  final Show show;

  Widget _buildEventPortraitAndInfo() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPortraitPhoto(),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 48.0,
            ),
            child: _buildEventInfo(),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitPhoto() {
    return new Hero(
      tag: event.id,
      child: new EventPoster(
        url: event.images.portraitMedium,
        size: new Size(100.0, 150.0),
        useShadow: true,
      ),
    );
  }

  Widget _buildEventInfo() {
    var content = <Widget>[
      new Text(
        event.title,
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Text(
          '${event.lengthInMinutes}min | ${event.genres.split(', ').take(4).join(', ')}',
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ];

    if (event.directors.isNotEmpty) {
      var directorInfo = new Row(
        children: <Widget>[
          new Text(
            'Director:',
            style: new TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: new Text(
              event.directors.first,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      );

      content.add(new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: directorInfo,
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 118.0),
            child: new EventHeader(event),
          ),
          new Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 4.0,
            child: new Material(
              type: MaterialType.circle,
              color: Colors.transparent,
              child: new BackButton(color: Colors.white.withOpacity(0.9)),
            ),
          ),
          new Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 0.0,
            child: _buildEventPortraitAndInfo(),
          ),
        ],
      ),
    ];

    if (show != null) {
      content.add(new Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Icon(
                  Icons.schedule,
                  color: Colors.black87,
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 16.0),
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
                ),
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new RaisedButton(
                onPressed: () async {
                  if (await canLaunch(show.url)) {
                    await launch(show.url);
                  }
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: new Text('Buy Tickets'),
              ),
            ),
          ],
        ),
      ));
    }

    if (event.hasSynopsis) {
      content.add(new Padding(
        padding: new EdgeInsets.only(top: show == null? 12.0 : 0.0),
        child: new StorylineWidget(event),
      ));
    }

    if (event.actors.isNotEmpty) {
      content.add(new ActorScroller(event));
    }

    return new Scaffold(
      body: new SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: new Column(children: content),
      ),
    );
  }
}
