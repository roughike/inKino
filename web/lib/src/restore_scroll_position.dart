import 'dart:async';
import 'dart:html';

import 'package:angular_router/angular_router.dart';

void storeCurrentScrollPosition() =>
    window.sessionStorage['scrollY'] = window.scrollY.toString();

void restoreScrollPositionIfNeeded(
    RouterState previous, RoutePath restoreWhenComingFrom) {
  final shouldRestoreScrollPosition =
      previous?.routePath?.path == restoreWhenComingFrom.path;

  if (shouldRestoreScrollPosition) {
    Timer(Duration.zero, () {
      window.scrollTo(0, int.tryParse(window.sessionStorage['scrollY'] ?? '0'));
    });
  } else {
    window.scrollTo(0, 0);
  }
}
