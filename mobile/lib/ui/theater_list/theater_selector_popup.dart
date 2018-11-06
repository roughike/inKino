import 'package:flutter/material.dart';
import 'package:inkino/ui/theater_list/theater_list.dart';

class TheaterSelectorPopup extends PopupRoute {
  final opacityTween = Tween(begin: 0.0, end: 1.0);
  final positionTween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.decelerate,
    );

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRect(
        child: FadeTransition(
          opacity: opacityTween.animate(curve),
          child: SlideTransition(
            position: positionTween.animate(curve),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Container(
      color: const Color(0xFF152451),
      child: TheaterList(onTheaterTapped: () => Navigator.pop(context)),
    );
  }
}
