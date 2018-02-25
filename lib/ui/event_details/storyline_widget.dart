import 'package:flutter/material.dart';
import 'package:inkino/data/event.dart';

class StorylineWidget extends StatefulWidget {
  StorylineWidget(this.event);
  final Event event;

  @override
  _StorylineWidgetState createState() => new _StorylineWidgetState();
}

class _StorylineWidgetState extends State<StorylineWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: new InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: new Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Storyline',
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new AnimatedCrossFade(
                  firstChild: new Text(widget.event.shortSynopsis),
                  secondChild: new Text(widget.event.synopsis),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: kThemeAnimationDuration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
