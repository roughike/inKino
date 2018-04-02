import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/data/networking/tmdb_api.dart';
import 'package:inkino/ui/event_details/actor_scroller.dart';
import 'package:inkino/ui/event_details/event_header.dart';
import 'package:inkino/ui/event_details/showtime_information.dart';
import 'package:inkino/ui/event_details/storyline_widget.dart';
import 'package:inkino/ui/events/event_poster.dart';

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
  // TODO: Possibly refactor the actor avatar loading to a more appropriate
  // place.
  static final TMDBApi api = new TMDBApi();

  ScrollController _scrollController;
  double _scrollOffset = 0.0;

  bool _avatarsLoaded = false;
  List<Actor> _actors;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);

    _actors = widget.event.actors;
    _fetchActorAvatars();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  Future<Null> _fetchActorAvatars() async {
    var actorsWithAvatars = await api.findAvatarsForActors(
      widget.event,
      widget.event.actors,
    );

    if (!mounted) return;

    setState(() {
      _actors = actorsWithAvatars;
      _avatarsLoaded = true;
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
      child: new Stack(
        children: <Widget>[
          new Hero(
            tag: widget.event.id,
            child: new EventPoster(
              event: widget.event,
              size: new Size(100.0, 150.0),
              displayPlayButton: true,
            ),
          ),
        ],
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
    return <Widget>[
      new Text(
        widget.event.cleanedUpTitle,
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Text(
          '${widget.event.lengthInMinutes}min | ${widget.event.genres.split(', ').take(4).join(', ')}',
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

  Widget _buildActorScroller() => widget.event.actors.isNotEmpty
      ? new ActorScroller(_actors, _avatarsLoaded)
      : null;

  void _addIfNonNull(Widget child, List<Widget> children) {
    if (child != null) {
      children.add(child);
    }
  }

  double _headerOffset(double backdropHeight) {
    if (backdropHeight < 80.0) {
      return -(80.0 - backdropHeight);
    }

    return 0.0;
  }

  Widget _buildEventBackdrop() {
    var unconstrainedBackdropHeight = 175.0 + (-_scrollOffset);
    var backdropHeight = max(80.0, unconstrainedBackdropHeight);
    var backdropExpandBlur = max(0.0, min(20.0, -_scrollOffset / 6));
    var overlayOpacity = max(
        0.0, min(1.0, 2.0 - (unconstrainedBackdropHeight / kToolbarHeight)));
    var backdropFinalBlur =
        backdropExpandBlur == 0.0 ? overlayOpacity * 5.0 : backdropExpandBlur;

    if (_scrollOffset < 0) {
      overlayOpacity = max(0.0, min(1.0, -(_scrollOffset / 150)));
    }

    return new Positioned(
      top: _headerOffset(unconstrainedBackdropHeight),
      child: new ClipRect(
        child: new Stack(
          children: <Widget>[
            new EventHeader(
              widget.event,
              backdropHeight,
            ),
            new BackdropFilter(
              filter: new ui.ImageFilter.blur(
                sigmaX: backdropFinalBlur,
                sigmaY: backdropFinalBlur,
              ),
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: backdropHeight,
                decoration: new BoxDecoration(
                  color: Colors.black.withOpacity(overlayOpacity * 0.4),
                ),
              ),
            ),
            new Positioned(
              bottom: -8.0,
              child: new DecoratedBox(
                decoration: new BoxDecoration(
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                ),
                child: new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    var content = <Widget>[
      _buildHeader(context),
    ];

    _addIfNonNull(_buildShowtimeInformation(), content);
    _addIfNonNull(_buildSynopsis(), content);
    _addIfNonNull(_buildActorScroller(), content);

    // Some padding for the bottom.
    content.add(new Container(height: 32.0));

    return new CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        new SliverList(
          delegate: new SliverChildListDelegate(content),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    var opacity = 1.0;

    if (_scrollOffset > 80.0) {
      opacity = max(0.0, min(1.0, 1.0 - ((_scrollOffset - 80.0) / 5)));
    } else if (_scrollOffset < 0.0) {
      opacity = max(0.0, min(1.0, 1.0 - (_scrollOffset / -40)));
    }

    return new Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: new IgnorePointer(
        ignoring: opacity == 0.0,
        child: new Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: new BackButton(
            color: Colors.white.withOpacity(opacity * 0.9),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBarBackground() {
    var statusBarMaxHeight = MediaQuery.of(context).padding.vertical;
    var statusBarHeight = max(
        0.0,
        min(
          statusBarMaxHeight,
          _scrollOffset - 175.0 + (statusBarMaxHeight * 4.5),
        ));
    var statusBarColor = Theme.of(context).primaryColor;

    return new Container(
      height: statusBarHeight,
      color: statusBarColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          _buildEventBackdrop(),
          _buildContent(),
          _buildBackButton(),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}
