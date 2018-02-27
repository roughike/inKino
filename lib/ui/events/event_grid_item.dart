import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';

class EventGridItem extends StatelessWidget {
  EventGridItem(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(color: Colors.white),
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Hero(
            tag: event.id,
            child: new Image.network(event.images.portraitMedium),
          ),
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: <double>[
                  0.0,
                  0.7,
                  0.7,
                ],
                colors: <Color>[
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
            padding: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  event.title,
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    event.genres,
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (_) => new EventDetailsPage(event),
                  ),
                );
              },
              child: new Container(),
            ),
          ),
        ],
      ),
    );
  }
}
