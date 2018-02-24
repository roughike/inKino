import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';

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
          new Placeholder(),
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.black54,
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
                  style: new TextStyle(fontWeight: FontWeight.w500),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    event.genres,
                    style: new TextStyle(fontSize: 12.0),
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
