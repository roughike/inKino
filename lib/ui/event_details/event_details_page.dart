import 'package:flutter/material.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/ui/event_details/actor_scroller.dart';
import 'package:inkino/ui/event_details/event_backdrop_photo.dart';
import 'package:inkino/ui/event_details/event_details_scroll_effects.dart';
import 'package:inkino/ui/event_details/showtime_information.dart';
import 'package:inkino/ui/event_details/storyline_widget.dart';
import 'package:inkino/ui/events/event_poster.dart';
import 'package:inkino/utils/widget_utils.dart';

class EventDetailsPage extends StatefulWidget {
  EventDetailsPage(
    this.event, {
    this.show,
  });

  final Event event;
  final Show show;

  @override
  _EventDetailsPageState createState() => new _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  ScrollController _scrollController;
  EventDetailsScrollEffects _scrollEffects;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollEffects = new EventDetailsScrollEffects();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _scrollEffects.updateScrollOffset(context, _scrollController.offset);
    });
  }

  Widget _buildHeader(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // Transparent container that makes the space for the backdrop photo.
        new Container(
          height: 175.0,
          margin: const EdgeInsets.only(bottom: 118.0),
        ),
        new Positioned(
          left: 10.0,
          bottom: 0.0,
          child: _buildPortraitPhoto(),
        ),
        new Positioned(
          top: 186.0,
          left: 132.0,
          right: 16.0,
          child: _buildEventInfo(),
        ),
      ],
    );
  }

  Widget _buildPortraitPhoto() {
    return new Padding(
      padding: const EdgeInsets.all(6.0),
      child: new EventPoster(
        event: widget.event,
        size: const Size(100.0, 150.0),
        displayPlayButton: true,
      ),
    );
  }

  Widget _buildEventInfo() {
    var content = <Widget>[]..addAll(_buildTitleAndLengthInMinutes());

    if (widget.event.directors.isNotEmpty) {
      content.add(new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _buildDirectorInfo(),
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  List<Widget> _buildTitleAndLengthInMinutes() {
    var length = '${widget.event.lengthInMinutes} min';
    var genres = widget.event.genres.split(', ').take(4).join(', ');

    return <Widget>[
      new Text(
        widget.event.title,
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Text(
          '$length | $genres',
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ];
  }

  Widget _buildDirectorInfo() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          'Director:',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: new Text(
              widget.event.directors.first,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShowtimeInformation() {
    if (widget.show != null) {
      return new Padding(
        padding: const EdgeInsets.only(
          top: 24.0,
          bottom: 8.0,
          left: 16.0,
          right: 16.0,
        ),
        child: new ShowtimeInformation(widget.show),
      );
    }

    return null;
  }

  Widget _buildSynopsis() {
    if (widget.event.hasSynopsis) {
      return new Padding(
        padding: new EdgeInsets.only(top: widget.show == null ? 12.0 : 0.0),
        child: new StorylineWidget(widget.event),
      );
    }

    return null;
  }

  Widget _buildActorScroller() =>
      widget.event.actors.isNotEmpty ? new ActorScroller(widget.event) : null;

  Widget _buildEventBackdrop() {
    return new Positioned(
      top: _scrollEffects.headerOffset,
      child: new EventBackdropPhoto(
        event: widget.event,
        height: _scrollEffects.backdropHeight,
        overlayBlur: _scrollEffects.backdropOverlayBlur,
        blurOverlayOpacity: _scrollEffects.backdropOverlayOpacity,
      ),
    );
  }

  Widget _buildBackButton() {
    return new Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: new IgnorePointer(
        ignoring: _scrollEffects.backButtonOpacity == 0.0,
        child: new Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: new BackButton(
            color: Colors.white.withOpacity(
              _scrollEffects.backButtonOpacity * 0.9,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBarBackground() {
    var statusBarColor = Theme.of(context).primaryColor;

    return new Container(
      height: _scrollEffects.statusBarHeight,
      color: statusBarColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      _buildHeader(context),
    ];

    addIfNonNull(_buildShowtimeInformation(), content);
    addIfNonNull(_buildSynopsis(), content);
    addIfNonNull(_buildActorScroller(), content);

    // Some padding for the bottom.
    content.add(new Container(height: 32.0));

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          _buildEventBackdrop(),
          new CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              new SliverList(delegate: new SliverChildListDelegate(content)),
            ],
          ),
          _buildBackButton(),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}
