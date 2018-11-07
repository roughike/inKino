import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/message_provider.dart';

class StorylineWidget extends StatefulWidget {
  StorylineWidget(this.event);
  final Event event;

  @override
  _StorylineWidgetState createState() => _StorylineWidgetState();
}

class _StorylineWidgetState extends State<StorylineWidget> {
  bool _isExpandable;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpandable = widget.event.shortSynopsis != widget.event.synopsis;
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedCrossFade(
      firstChild: Text(widget.event.shortSynopsis),
      secondChild: Text(widget.event.synopsis),
      crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );

    return InkWell(
      onTap: _isExpandable ? _toggleExpandedState : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(_isExpandable, _isExpanded),
            const SizedBox(height: 8.0),
            content,
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.expandable, this.expanded);
  final bool expandable;
  final bool expanded;

  Widget _buildExpandCollapsePrompt(Messages messages) {
    const captionStyle = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

    return Text(
      expanded ? messages.collapseStoryline : messages.expandStoryline,
      style: captionStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    final content = <Widget>[
      Text(
        messages.storyline,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];

    if (expandable) {
      content.add(Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: _buildExpandCollapsePrompt(messages),
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: content,
    );
  }
}
