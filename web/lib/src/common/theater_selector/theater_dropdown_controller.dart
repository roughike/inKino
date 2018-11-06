import 'dart:async';

import 'package:angular/angular.dart';
import 'package:meta/meta.dart';

import 'theater_selector_dropdown_menu_component.template.dart' as dropdown;

class TheaterDropdownController {
  static const animationDuration = Duration(milliseconds: 250);

  TheaterDropdownController._(this._menu);
  ComponentRef _menu;

  bool get isDestroyed => _menu == null;
  bool visible = false;

  static Future<TheaterDropdownController> loadAndShow(
    ComponentLoader loader,
    ViewContainerRef container, {
    String background = 'rgba(26, 26, 26, 0.9)',
  }) async {
    final menu = await loader.loadNextToLocation(
      dropdown.TheaterSelectorDropdownMenuComponentNgFactory,
      container,
    );

    final controller = TheaterDropdownController._(menu);
    menu.instance
      ..controller = controller
      ..background = background;

    return controller
      ..visible = true
      .._menuAnimation(visible: true);
  }

  void hideAndDestroy() {
    visible = false;
    _menuAnimation(
      visible: false,
      afterAnimation: () {
        _menu.destroy();
        _menu = null;
      },
    );
  }

  void _menuAnimation({@required bool visible, void afterAnimation()}) {
    Timer(
      const Duration(milliseconds: 25),
      () => _menu?.instance?.isOpen = visible,
    );

    if (afterAnimation != null) {
      Timer(animationDuration, afterAnimation);
    }
  }
}
