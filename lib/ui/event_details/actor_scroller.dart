import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/networking/tmdb_api.dart';
import 'package:inkino/assets.dart';

class ActorScroller extends StatefulWidget {
  ActorScroller(this.actors, this.avatarsLoaded);

  final List<Actor> actors;
  final bool avatarsLoaded;

  @override
  _ActorScrollerState createState() => new _ActorScrollerState();
}

class _ActorScrollerState extends State<ActorScroller> {
  Widget _buildActorList() {
    return new ListView.builder(
      padding: const EdgeInsets.only(left: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: widget.actors.length,
      itemBuilder: (BuildContext context, int index) {
        var actor = widget.actors[index];
        return _buildActorListItem(actor);
      },
    );
  }

  Widget _buildActorListItem(Actor actor) {
    return new Container(
      width: 90.0,
      padding: const EdgeInsets.only(right: 16.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: 56.0,
            height: 56.0,
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: new Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: <Widget>[
                new Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 26.0,
                ),
                new ClipOval(
                  child: new FadeInImage.assetNetwork(
                    placeholder: ImageAssets.transparentImage,
                    // FIXME: The example.com here is a hack to not make the
                    // FadeInImage crash when there's no avatar url for
                    // the actor.
                    image: actor.avatarUrl ?? 'https://example.com',
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 250),
                  ),
                ),
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text(
              widget.avatarsLoaded ? actor.name : 'Loading...',
              style: new TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(
              'Cast',
              style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: new SizedBox.fromSize(
              size: new Size.fromHeight(110.0),
              child: _buildActorList(),
            ),
          ),
        ],
      ),
    );
  }
}
