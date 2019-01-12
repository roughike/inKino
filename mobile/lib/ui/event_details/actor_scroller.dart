import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/message_provider.dart';
import 'package:kt_dart/collection.dart';

class ActorScroller extends StatelessWidget {
  const ActorScroller(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, KtList<Actor>>(
      onInit: (store) => store.dispatch(FetchActorAvatarsAction(event)),
      converter: (store) => actorsForEventSelector(store.state, event),
      builder: (_, actors) => ActorScrollerContent(actors),
    );
  }
}

class ActorScrollerContent extends StatelessWidget {
  const ActorScrollerContent(this.actors);
  final KtList<Actor> actors;

  @override
  Widget build(BuildContext context) {
    return _ActorScrollerWrapper(
      ListView.builder(
        padding: const EdgeInsets.only(left: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: actors.size,
        itemBuilder: (_, int index) {
          final actor = actors[index];
          return _ActorListItem(actor);
        },
      ),
    );
  }
}

class _ActorScrollerWrapper extends StatelessWidget {
  _ActorScrollerWrapper(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0.0, -2.0),
          spreadRadius: 2.0,
          blurRadius: 30.0,
          color: Colors.black12,
        ),
      ],
    );

    final title = Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        MessageProvider.of(context).cast,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return Container(
      decoration: decoration,
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          title,
          const SizedBox(height: 16.0),
          SizedBox(
            height: 110.0,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _ActorListItem extends StatelessWidget {
  _ActorListItem(this.actor);
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          _ActorAvatar(actor),
          const SizedBox(height: 8.0),
          Text(
            actor.name,
            style: const TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActorAvatar extends StatelessWidget {
  _ActorAvatar(this.actor);
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
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
}
