import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/data/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventHeader extends StatelessWidget {
  EventHeader(this.event);
  final Event event;

  Widget _buildPlaceholderBackground() {
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
          color: Colors.white30,
          size: 96.0,
        ),
      ),
    );
  }

  Widget _buildBackdropPhoto(BuildContext context) {
    var photoUrl = event.images.landscapeBig ?? event.images.landscapeSmall;

    if (photoUrl != null) {
      return new FadeInImage.assetNetwork(
        placeholder: ImageAssets.transparentImage,
        image: photoUrl,
        width: MediaQuery.of(context).size.width,
        height: 175.0,
        fadeInDuration: const Duration(milliseconds: 300),
        fit: BoxFit.cover,
      );
    }

    return null;
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

  void _addIfNonNull(Widget child, List<Widget> children) {
    if (child != null) {
      children.add(child);
    }
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      _buildPlaceholderBackground(),
    ];

    _addIfNonNull(_buildBackdropPhoto(context), content);
    _addIfNonNull(_buildPlayButton(), content);

    return new Stack(
      alignment: Alignment.center,
      children: content,
    );
  }
}
