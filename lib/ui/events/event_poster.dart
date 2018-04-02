import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:meta/meta.dart';

class EventPoster extends StatelessWidget {
  EventPoster({
    @required this.url,
    this.size,
  });

  final String url;
  final Size size;

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
            image: url ?? '',
            width: size?.width,
            height: size?.height,
            fadeInDuration: const Duration(milliseconds: 300),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
