import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/message_provider.dart';

class EventGalleryGrid extends StatelessWidget {
  EventGalleryGrid(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(),
          _Grid(event),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        MessageProvider.of(context).gallery,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  _Grid(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.25 / 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      children: event.galleryImages.map((image) {
        return _GalleryImage(image.location);
      }).list,
    );
  }
}

class _GalleryImage extends StatelessWidget {
  _GalleryImage(this.url);
  final String url;

  @override
  Widget build(BuildContext context) {
    final decoration = const BoxDecoration(
      boxShadow: [
        BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 5.0,
          offset: Offset(2.0, 2.0),
          color: Colors.black38,
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: decoration,
      child: FadeInImage.assetNetwork(
        placeholder: ImageAssets.transparentImage,
        image: url,
        fit: BoxFit.cover,
      ),
    );
  }
}
