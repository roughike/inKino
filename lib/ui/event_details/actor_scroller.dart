import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/actor/actor_selectors.dart';
import 'package:inkino/redux/app/app_state.dart';

class ActorScroller extends StatelessWidget {
  const ActorScroller(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Actor>>(
      onInit: (store) => store.dispatch(FetchActorAvatarsAction(event)),
      converter: (store) => actorsForEventSelector(store.state, event),
      builder: (_, actors) => ActorScrollerContent(actors),
    );
  }
}

class ActorScrollerContent extends StatelessWidget {
  const ActorScrollerContent(this.actors);
  final List<Actor> actors;

  Widget _buildActorList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: actors.length,
      itemBuilder: (BuildContext context, int index) {
        var actor = actors[index];
        return _buildActorListItem(context, actor);
      },
    );
  }

  Widget _buildActorListItem(BuildContext context, Actor actor) {
    var actorName = Text(
      actor.name,
      style: const TextStyle(fontSize: 12.0),
      textAlign: TextAlign.center,
    );

    return Container(
      width: 90.0,
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: <Widget>[
          _buildActorAvatar(context, actor),
          const SizedBox(height: 8.0),
          actorName,
        ],
      ),
    );
  }

  Widget _buildActorAvatar(BuildContext context, Actor actor) {
    var content = <Widget>[
      const Icon(
        Icons.person,
        color: Colors.white,
        size: 26.0,
      ),
    ];

    if (actor.avatarUrl != null) {
      content.add(ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: ImageAssets.transparentImage,
          image: actor.avatarUrl,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 250),
        ),
      ));
    }

    return Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text(
              'Cast',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox.fromSize(
            size: const Size.fromHeight(110.0),
            child: _buildActorList(context),
          ),
        ],
      ),
    );
  }
}
