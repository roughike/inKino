import 'package:flutter/material.dart';

class ActorScroller extends StatelessWidget {
  ActorScroller(this.actorNames);
  final List<String> actorNames;

  Widget _buildActorList() {
    return new ListView.builder(
      padding: const EdgeInsets.only(left: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: actorNames.length,
      itemBuilder: (BuildContext context, int index) {
        var actorName = actorNames[index];
        return _buildActorListItem(actorName);
      },
    );
  }

  Widget _buildActorListItem(String actorName) {
    return new Container(
      width: 90.0,
      padding: const EdgeInsets.only(right: 16.0),
      child: new Column(
        children: <Widget>[
          new CircleAvatar(
            radius: 28.0,
            child: new Icon(
              Icons.person,
              color: Colors.white,
              size: 26.0,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text(
              actorName,
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
      padding: const EdgeInsets.only(top: 24.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
