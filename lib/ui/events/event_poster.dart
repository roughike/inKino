import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/utils/widget_utils.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

@visibleForTesting
Function(String) launchTrailerVideo = (url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
};

class EventPoster extends StatelessWidget {
  static final Key playButtonKey = new Key('playButton');

  EventPoster({
    @required this.event,
    this.size,
    this.displayPlayButton = false,
  });

  final Event event;
  final Size size;
  final bool displayPlayButton;

  BoxDecoration _buildDecorations() {
    return new BoxDecoration(
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
    );
  }

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
            key: playButtonKey,
            padding: EdgeInsets.zero,
            icon: new Icon(Icons.play_circle_outline),
            iconSize: 42.0,
            color: Colors.white.withOpacity(0.8),
            onPressed: () {
              var url = event.youtubeTrailers.first;
              launchTrailerVideo(url);
            },
          ),
        ),
      );
    }

    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      new Icon(
        Icons.local_movies,
        color: Colors.white24,
        size: 72.0,
      ),
      new FadeInImage.assetNetwork(
        placeholder: ImageAssets.transparentImage,
        image: event.images.portraitMedium ?? '',
        width: size?.width,
        height: size?.height,
        fadeInDuration: const Duration(milliseconds: 300),
        fit: BoxFit.cover,
      ),
    ];

    addIfNonNull(_buildPlayButton(), content);

    return new Container(
      decoration: _buildDecorations(),
      width: size?.width,
      height: size?.height,
      child: new Stack(
        alignment: Alignment.center,
        children: content,
      ),
    );
  }
}
