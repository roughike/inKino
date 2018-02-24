import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 118.0),
            child: new Image.network(
              event.images.landscapeBig,
              height: 175.0,
              fit: BoxFit.cover,
            ),
          ),
          new Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 0.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new DecoratedBox(
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
                ),
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 48.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          event.title,
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: new Text(
                            // TODO: Add actual movie length
                            '90min | ' + event.genres,
                            style: new TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        new Padding(
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
                                  // TODO: Replace with actual director
                                  'Clint Eastwood',
                                  style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
