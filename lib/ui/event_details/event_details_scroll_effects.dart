import 'dart:math';

import 'package:flutter/material.dart';

// FIXME: This is ugly, but works. Look into doing this with Animations and
// Tweens instead.
class EventDetailsScrollEffects {
  static const double kHeaderHeight = 175.0;

  EventDetailsScrollEffects() {
    updateScrollOffset(null, 0.0);
  }

  double _scrollOffset;

  double backdropHeight;
  double backdropOverlayOpacity;
  double backdropOverlayBlur;
  double headerOffset;

  double backButtonOpacity;
  double statusBarHeight;

  void updateScrollOffset(BuildContext context, double offset) {
    _scrollOffset = offset;
    _recalculateValues(context);
  }

  void _recalculateValues(BuildContext context) {
    var unconstrainedBackdropHeight = kHeaderHeight + (-_scrollOffset);

    backdropHeight = max(80.0, unconstrainedBackdropHeight);
    backdropOverlayOpacity =
        _calculateOverlayOpacity(unconstrainedBackdropHeight);
    backdropOverlayBlur = _calculateBackdropBlur();
    headerOffset = _calculateHeaderOffset(unconstrainedBackdropHeight);
    backButtonOpacity = _calculateBackButtonOpacity();
    statusBarHeight = _calculateStatusBarHeight(context);
  }

  double _calculateOverlayOpacity(double unconstrainedBackdropHeight) {
    var opacity = max(
      0.0,
      min(1.0, 2.0 - (unconstrainedBackdropHeight / kToolbarHeight)),
    );

    if (_scrollOffset < 0) {
      opacity = max(0.0, min(1.0, -(_scrollOffset / 150)));
    }

    return opacity;
  }

  double _calculateBackdropBlur() {
    var backdropOverscrollBlur = max(0.0, min(20.0, -_scrollOffset / 6));

    return backdropOverscrollBlur == 0.0
        ? backdropOverlayOpacity * 5.0
        : backdropOverscrollBlur;
  }

  double _calculateHeaderOffset(double unconstrainedBackdropHeight) {
    if (unconstrainedBackdropHeight < 80.0) {
      return -(80.0 - unconstrainedBackdropHeight);
    }

    return 0.0;
  }

  double _calculateBackButtonOpacity() {
    if (_scrollOffset > 80.0) {
      return max(0.0, min(1.0, 1.0 - ((_scrollOffset - 80.0) / 5)));
    } else if (_scrollOffset < 0.0) {
      return max(0.0, min(1.0, 1.0 - (_scrollOffset / -40)));
    }

    return 1.0;
  }

  double _calculateStatusBarHeight(BuildContext context) {
    double statusBarMaxHeight = 0.0;

    if (context != null) {
      statusBarMaxHeight = MediaQuery.of(context).padding.top;
    }

    return max(
      0.0,
      min(
        statusBarMaxHeight,
        _scrollOffset - kHeaderHeight + (statusBarMaxHeight * 4),
      ),
    );
  }
}
