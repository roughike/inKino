import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/utils/widget_utils.dart';
import 'package:meta/meta.dart';

class EventBackdropPhoto extends StatelessWidget {
  EventBackdropPhoto({
    @required this.event,
    @required this.height,
    @required this.overlayBlur,
    @required this.blurOverlayOpacity,
  });

  final Event event;
  final double height;
  final double overlayBlur;
  final double blurOverlayOpacity;

  Widget _buildBackdropPhotoWithPlaceholder(BuildContext context) {
    var content = <Widget>[
      _buildPlaceholderBackground(context),
    ];

    addIfNonNull(_buildBackdropPhoto(context), content);

    return new Stack(
      alignment: Alignment.center,
      children: content,
    );
  }

  Widget _buildPlaceholderBackground(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: height,
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

  Widget _buildBlurOverlay(BuildContext context) {
    return new BackdropFilter(
      filter: new ui.ImageFilter.blur(
        sigmaX: overlayBlur,
        sigmaY: overlayBlur,
      ),
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: new BoxDecoration(
          color: Colors.black.withOpacity(blurOverlayOpacity * 0.4),
        ),
      ),
    );
  }

  Widget _buildShadowInset(BuildContext context) {
    return new Positioned(
      bottom: -8.0,
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: new SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 10.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: <Widget>[
          _buildBackdropPhotoWithPlaceholder(context),
          _buildBlurOverlay(context),
          _buildShadowInset(context),
        ],
      ),
    );
  }
}
