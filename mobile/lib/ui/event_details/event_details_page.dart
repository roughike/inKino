import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/message_provider.dart';
import 'package:inkino/ui/event_details/actor_scroller.dart';
import 'package:inkino/ui/event_details/event_backdrop_photo.dart';
import 'package:inkino/ui/event_details/event_details_scroll_effects.dart';
import 'package:inkino/ui/event_details/event_gallery_grid.dart';
import 'package:inkino/ui/event_details/storyline_widget.dart';
import 'package:inkino/ui/events/event_poster.dart';
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';
import 'package:inkino/ui/common/widget_utils.dart';

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

  Widget _buildShowtimeInformation() {
    if (widget.show != null) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowtimeListTile(
            widget.show,
            opensEventDetails: false,
          ),
        ),
      );
    }

    return null;
  }

  Widget _buildSynopsis() {
    if (widget.event.hasSynopsis) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: widget.show == null ? 12.0 : 0.0,
          bottom: 16.0,
        ),
        child: StorylineWidget(widget.event),
      );
    }

    return null;
  }

  Widget _buildActorScroller() =>
      widget.event.actors.isNotEmpty() ? ActorScroller(widget.event) : null;

  Widget _buildGallery() => widget.event.galleryImages.isNotEmpty()
      ? EventGalleryGrid(widget.event)
      : Container(color: Colors.white, height: 500.0);

  Widget _buildEventBackdrop() {
    return Positioned(
      top: _scrollEffects.headerOffset,
      child: EventBackdropPhoto(
        event: widget.event,
        scrollEffects: _scrollEffects,
      ),
    );
  }

  Widget _buildStatusBarBackground() {
    final statusBarColor = Theme.of(context).primaryColor;

    return Container(
      height: _scrollEffects.statusBarHeight,
      color: statusBarColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      _Header(widget.event),
    ];

    addIfNonNull(_buildShowtimeInformation(), content);
    addIfNonNull(_buildSynopsis(), content);
    addIfNonNull(_buildActorScroller(), content);
    addIfNonNull(_buildGallery(), content);

    // Some padding for the bottom.
    content.add(const SizedBox(height: 32.0));

    final backgroundImage = Positioned.fill(
      child: Image.asset(
        ImageAssets.backgroundImage,
        fit: BoxFit.cover,
      ),
    );

    final slivers = CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(delegate: SliverChildListDelegate(content)),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Stack(
        children: [
          backgroundImage,
          _buildEventBackdrop(),
          slivers,
          _BackButton(_scrollEffects),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  _Header(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    final moviePoster = Padding(
      padding: const EdgeInsets.all(6.0),
      child: EventPoster(
        event: event,
        size: const Size(125.0, 187.5),
        displayPlayButton: true,
      ),
    );

    return Stack(
      children: [
        // Transparent container that makes the space for the backdrop photo.
        Container(
          height: 225.0,
          margin: const EdgeInsets.only(bottom: 132.0),
        ),
        // Makes for the white background in poster and event information.
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: Colors.white,
            height: 132.0,
          ),
        ),
        Positioned(
          left: 10.0,
          bottom: 0.0,
          child: moviePoster,
        ),
        Positioned(
          top: 238.0,
          left: 156.0,
          right: 16.0,
          child: _EventInfo(event),
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  _BackButton(this.scrollEffects);
  final EventDetailsScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: IgnorePointer(
        ignoring: scrollEffects.backButtonOpacity == 0.0,
        child: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: BackButton(
            color: Colors.white.withOpacity(
              scrollEffects.backButtonOpacity * 0.9,
            ),
          ),
        ),
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  _EventInfo(this.event);
  final Event event;

  List<Widget> _buildTitleAndLengthInMinutes() {
    final length = '${event.lengthInMinutes} min';
    final genres = event.genres.split(', ').take(4).join(', ');

    return [
      Text(
        event.title,
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

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[]..addAll(
        _buildTitleAndLengthInMinutes(),
      );

    if (event.directors.isNotEmpty()) {
      content.add(Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _DirectorInfo(event.director),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }
}

class _DirectorInfo extends StatelessWidget {
  _DirectorInfo(this.director);
  final String director;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${messages.director}:',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            director,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
