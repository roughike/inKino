import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InkinoBottomBar extends StatelessWidget {
  InkinoBottomBar({
    @required this.currentIndex,
    @required this.onTap,
    @required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    /// Yes - I'm using CupertinoTabBar on both Android and iOS. It looks dope.
    /// I'm not a designer and only God can judge me. (╯°□°）╯︵ ┻━┻
    return CupertinoTabBar(
      backgroundColor: Colors.black54,
      inactiveColor: Colors.white54,
      activeColor: Colors.white,
      iconSize: 24.0,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
