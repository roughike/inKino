import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/data/models/event.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPoster extends StatelessWidget {
  EventPoster({
    @required this.event,
    this.size,
    this.displayPlayButton = false,
  });

  final Event event;
  final Size size;
  final bool displayPlayButton;

  Widget _buildPlayButton() {
    if (displayPlayButton && event.youtubeTrailers.isNotEmpty) {
      return new DecoratedBox(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
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

    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        boxShadow: <BoxShadow>[
          new BoxShadow(
            offset: const Offset(1.0, 1.0),
            spreadRadius: 1.0,
            blurRadius: 2.0,
            color: Colors.black38,
          ),
        ],
        gradient: new LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            const Color(0xFF222222),
            const Color(0xFF424242),
          ],
        ),
      ),
      width: size?.width,
      height: size?.height,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Icon(
            Icons.local_movies,
            color: Colors.white24,
            size: 72.0,
          ),
          new FadeInImage.assetNetwork(
            placeholder: ImageAssets.transparentImage,
            image: event.images.portraitMedium ?? 'http://example.com',
            width: size?.width,
            height: size?.height,
            fadeInDuration: const Duration(milliseconds: 300),
            fit: BoxFit.cover,
          ),
          _buildPlayButton(),
        ],
      ),
    );
  }
}
