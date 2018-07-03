import 'package:flutter/material.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/models/show.dart';
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
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  ScrollController _scrollController;
  EventDetailsScrollEffects _scrollEffects;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollEffects = EventDetailsScrollEffects();
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
    return Stack(
      children: <Widget>[
        // Transparent container that makes the space for the backdrop photo.
        Container(
          height: 175.0,
          margin: const EdgeInsets.only(bottom: 118.0),
        ),
        Positioned(
          left: 10.0,
          bottom: 0.0,
          child: _buildPortraitPhoto(),
        ),
        Positioned(
          top: 186.0,
          left: 132.0,
          right: 16.0,
          child: _buildEventInfo(),
        ),
      ],
    );
  }

  Widget _buildPortraitPhoto() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: EventPoster(
        event: widget.event,
        size: const Size(100.0, 150.0),
        displayPlayButton: true,
      ),
    );
  }

  Widget _buildEventInfo() {
    var content = <Widget>[]..addAll(
        _buildTitleAndLengthInMinutes(),
      );

    if (widget.event.directors.isNotEmpty) {
      content.add(Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _buildDirectorInfo(),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  List<Widget> _buildTitleAndLengthInMinutes() {
    var length = '${widget.event.lengthInMinutes} min';
    var genres = widget.event.genres.split(', ').take(4).join(', ');

    return <Widget>[
      Text(
        widget.event.title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        '$length | $genres',
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }

  Widget _buildDirectorInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Director:',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            widget.event.directors.first,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShowtimeInformation() {
    if (widget.show != null) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 24.0,
          bottom: 8.0,
          left: 16.0,
          right: 16.0,
        ),
        child: ShowtimeInformation(widget.show),
      );
    }

    return null;
  }

  Widget _buildSynopsis() {
    if (widget.event.hasSynopsis) {
      return Padding(
        padding: EdgeInsets.only(top: widget.show == null ? 12.0 : 0.0),
        child: StorylineWidget(widget.event),
      );
    }

    return null;
  }

  Widget _buildActorScroller() =>
      widget.event.actors.isNotEmpty ? ActorScroller(widget.event) : null;

  Widget _buildEventBackdrop() {
    return Positioned(
      top: _scrollEffects.headerOffset,
      child: EventBackdropPhoto(
        event: widget.event,
        height: _scrollEffects.backdropHeight,
        overlayBlur: _scrollEffects.backdropOverlayBlur,
        blurOverlayOpacity: _scrollEffects.backdropOverlayOpacity,
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: IgnorePointer(
        ignoring: _scrollEffects.backButtonOpacity == 0.0,
        child: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: BackButton(
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

    return Container(
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
    content.add(const SizedBox(height: 32.0));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _buildEventBackdrop(),
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(delegate: SliverChildListDelegate(content)),
            ],
          ),
          _buildBackButton(),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}
