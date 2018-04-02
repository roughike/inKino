import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/data/models/event.dart';

class EventHeader extends StatelessWidget {
  EventHeader(
    this.event,
    this.height,
  );

  final Event event;
  final double height;

  Widget _buildPlaceholderBackground(BuildContext context) {
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
      width: MediaQuery.of(context).size.width,
      height: height,
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
      var screenWidth = MediaQuery.of(context).size.width;

      return new SizedBox(
        width: screenWidth,
        height: height,
        child: new FadeInImage.assetNetwork(
          placeholder: ImageAssets.transparentImage,
          image: photoUrl,
          width: screenWidth,
          height: height,
          fadeInDuration: const Duration(milliseconds: 300),
          fit: BoxFit.cover,
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
      _buildPlaceholderBackground(context),
    ];

    _addIfNonNull(_buildBackdropPhoto(context), content);

    return new Stack(
      alignment: Alignment.center,
      children: content,
    );
  }
}
