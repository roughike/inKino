import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class EventPoster extends StatelessWidget {
  EventPoster({
    @required this.url,
    this.size,
    this.useShadow = false,
  });

  final String url;
  final Size size;
  final bool useShadow;

  @override
  Widget build(BuildContext context) {
    var shadows = <BoxShadow>[];

    if (useShadow) {
      shadows.add(new BoxShadow(
        offset: const Offset(1.0, 1.0),
        spreadRadius: 1.0,
        blurRadius: 2.0,
        color: Colors.black38,
      ));
    }

    return new Container(
      decoration: new BoxDecoration(
        boxShadow: shadows,
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
            placeholder: 'assets/images/1x1_transparent.png',
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
