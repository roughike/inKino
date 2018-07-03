import 'package:flutter/material.dart';
import 'package:inkino/models/event.dart';

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

  Widget _buildCaption() {
    var content = <Widget>[
      const Text(
        'Storyline',
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];

    if (_isExpandable) {
      content.add(Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: _buildExpandCollapsePrompt(),
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: content,
    );
  }

  Widget _buildExpandCollapsePrompt() {
    const captionStyle = const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

    if (_isExpanded) {
      return const Text('[touch to collapse]', style: captionStyle);
    }

    return const Text('[touch to expand]', style: captionStyle);
  }

  Widget _buildContent() {
    return AnimatedCrossFade(
      firstChild: Text(widget.event.shortSynopsis),
      secondChild: Text(widget.event.synopsis),
      crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isExpandable ? _toggleExpandedState : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCaption(),
            const SizedBox(height: 8.0),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
