import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/networking/tmdb_api.dart';

class ActorScroller extends StatefulWidget {
  ActorScroller(this.event);

  final Event event;
  final TMDBApi api = new TMDBApi();

  @override
  _ActorScrollerState createState() => new _ActorScrollerState();
}

class _ActorScrollerState extends State<ActorScroller> {
  List<Actor> actors;

  @override
  void initState() {
    super.initState();
    actors = widget.event.actors;
    _fetchAvatars();
  }

  Future<void> _fetchAvatars() async {
    var actorsWithAvatars = await widget.api.findAvatarsForActors(
      widget.event,
      widget.event.actors,
    );

    setState(() {
      actors = actorsWithAvatars;
    });
  }

  Widget _buildActorList() {
    return new ListView.builder(
      padding: const EdgeInsets.only(left: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: actors.length,
      itemBuilder: (BuildContext context, int index) {
        var actor = actors[index];
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
            child: actor.avatarUrl == null
                ? new Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 26.0,
                  )
                : new ClipOval(
                    child: new Image.network(
                      actor.avatarUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text(
              actor.name,
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
              size: new Size.fromHeight(96.0),
              child: _buildActorList(),
            ),
          ),
        ],
      ),
    );
  }
}
