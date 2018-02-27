import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/ui/event_details/storyline_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage(this.event);
  final Event event;

  Widget _buildBackdropPhoto(BuildContext context) {
    var backdropPhoto =
        event.images.landscapeBig ?? event.images.landscapeSmall;
    var content = <Widget>[];

    if (backdropPhoto != null) {
      content.add(new Image.network(
        backdropPhoto,
        width: MediaQuery.of(context).size.width,
        height: 175.0,
        fit: BoxFit.cover,
      ));
    } else {
      content.add(new Container(
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
            color: Colors.white30,
            size: 96.0,
          ),
        ),
      ));
    }

    var playButton = _buildPlayButton();

    if (playButton != null) {
      content.add(playButton);
    }

    return new Stack(
      alignment: Alignment.center,
      children: content,
    );
  }

  Widget _buildPlayButton() {
    if (event.youtubeTrailers.isNotEmpty) {
      return new DecoratedBox(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black26,
        ),
        child: new Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: new IconButton(
            padding: EdgeInsets.zero,
            icon: new Icon(Icons.play_circle_outline),
            iconSize: 42.0,
            color: Colors.white.withOpacity(0.8),
            onPressed: () async {
              var url = event.youtubeTrailers.first;

              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
        ),
      );
    }

    return null;
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

  Widget _buildActorScroller() {
    return new Container(
      padding: const EdgeInsets.only(top: 24.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(
              'Cast',
              style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: new SizedBox.fromSize(
              size: new Size.fromHeight(96.0),
              child: new ListView.builder(
                padding: const EdgeInsets.only(left: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: event.actors.length,
                itemBuilder: (BuildContext context, int index) {
                  var actor = event.actors[index];

                  return new Container(
                    width: 90.0,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: new Column(
                      children: <Widget>[
                        new CircleAvatar(
                          radius: 28.0,
                          child: new Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 26.0,
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new Text(
                            actor,
                            style: new TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 118.0),
            child: _buildBackdropPhoto(context),
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
    ];

    if (event.actors.isNotEmpty) {
      content.add(_buildActorScroller());
    }

    content.add(new StorylineWidget(event));

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(children: content),
      ),
    );
  }
}
