import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/models/event.dart';
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
  static const Key playButtonKey = const Key('playButton');

  EventPoster({
    @required this.event,
    this.size,
    this.displayPlayButton = false,
  });

  final Event event;
  final Size size;
  final bool displayPlayButton;

  BoxDecoration _buildDecorations() {
    return const BoxDecoration(
      boxShadow: <BoxShadow>[
        const BoxShadow(
          offset: const Offset(1.0, 1.0),
          spreadRadius: 1.0,
          blurRadius: 2.0,
          color: Colors.black38,
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: const <Color>[
          const Color(0xFF222222),
          const Color(0xFF424242),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    if (displayPlayButton && event.youtubeTrailers.isNotEmpty) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: IconButton(
            key: playButtonKey,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.play_circle_outline),
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

    return null;
  }

  Widget _buildPosterImage() {
    if (event.images.portraitMedium == null) {
      return null;
    }

    return FadeInImage.assetNetwork(
      placeholder: ImageAssets.transparentImage,
      image: event.images.portraitMedium,
      width: size?.width,
      height: size?.height,
      fadeInDuration: const Duration(milliseconds: 300),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      const Icon(
        Icons.local_movies,
        color: Colors.white24,
        size: 72.0,
      ),
    ];

    addIfNonNull(_buildPosterImage(), content);
    addIfNonNull(_buildPlayButton(), content);

    return Container(
      decoration: _buildDecorations(),
      width: size?.width,
      height: size?.height,
      child: Stack(
        alignment: Alignment.center,
        children: content,
      ),
    );
  }
}
