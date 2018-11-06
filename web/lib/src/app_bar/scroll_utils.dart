import 'dart:async';
import 'dart:html';

enum ScrollDirection { up, down }

typedef void ScrollDirectionChangedCallback(ScrollDirection newDirection);

Timer listenForScrollDirectionChanges(ScrollDirectionChangedCallback callback) {
  var previousTop = 0;

  return Timer.periodic(const Duration(milliseconds: 250), (_) {
    final top = document.body.getBoundingClientRect().top;

    if (top > previousTop || top > -160) {
      callback(ScrollDirection.up);
    } else if (top < previousTop) {
      callback(ScrollDirection.down);
    }

    previousTop = top;
  });
}
