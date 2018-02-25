import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage(this.event);
  final Event event;

  Widget _buildBackdropPhoto() {
    var backdropPhoto =
        event.images.landscapeBig ?? event.images.landscapeSmall;

    if (backdropPhoto != null) {
      return new Image.network(
        backdropPhoto,
        height: 175.0,
        fit: BoxFit.cover,
      );
    }

    return new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            const Color(0xFF222222),
            const Color(0xFF424242),
          ],
        ),
      ),
      height: 175.0,
      child: new Center(
        child: new Icon(
          Icons.theaters,
          color: Colors.white70,
          size: 96.0,
        ),
      ),
    );
  }

  Widget _buildPortraitPhoto() {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        boxShadow: <BoxShadow>[
          new BoxShadow(
            offset: const Offset(1.0, 1.0),
            spreadRadius: 1.0,
            blurRadius: 2.0,
            color: Colors.black38,
          ),
        ],
      ),
      child: new Image.network(
        event.images.portraitMedium,
        height: 150.0,
        fit: BoxFit.cover,
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
          '${event.lengthInMinutes}min | ${event.genres}',
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ];

    if (event.directors.isNotEmpty) {
      content.add(new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Row(
          children: [
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
        ),
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 118.0),
            child: _buildBackdropPhoto(),
          ),
          new Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 0.0,
            child: new Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
