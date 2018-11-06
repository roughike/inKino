import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/ui/common/widget_utils.dart';
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

  Widget _buildPlayButton() =>
      displayPlayButton && event.youtubeTrailers.isNotEmpty
          ? _PlayButton(event)
          : null;

  Widget _buildPosterImage() => event.images.portraitMedium != null
      ? FadeInImage.assetNetwork(
          placeholder: ImageAssets.transparentImage,
          image: event.images.portraitMedium,
          width: size?.width,
          height: size?.height,
          fadeInDuration: const Duration(milliseconds: 300),
          fit: BoxFit.cover,
        )
      : null;

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
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

class _PlayButton extends StatelessWidget {
  _PlayButton(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black38,
      ),
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        child: IconButton(
          key: EventPoster.playButtonKey,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.play_circle_outline),
          iconSize: 42.0,
          color: Colors.white.withOpacity(0.8),
          onPressed: () {
            final url = event.youtubeTrailers.first;
            launchTrailerVideo(url);
          },
        ),
      ),
    );
  }
}

BoxDecoration _buildDecorations() {
  return const BoxDecoration(
    boxShadow: [
      BoxShadow(
        offset: Offset(1.0, 1.0),
        spreadRadius: 1.0,
        blurRadius: 2.0,
        color: Colors.black38,
      ),
    ],
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color(0xFF222222),
        Color(0xFF424242),
      ],
    ),
  );
}
