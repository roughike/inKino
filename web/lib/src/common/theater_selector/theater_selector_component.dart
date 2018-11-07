import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:web/src/common/theater_selector/theater_dropdown_controller.dart';

@Component(
  selector: 'theater-selector',
  styleUrls: ['theater_selector_component.css'],
  templateUrl: 'theater_selector_component.html',
)
class TheaterSelectorComponent {
  TheaterSelectorComponent(this._store, this._loader);
  final Store<AppState> _store;
  final ComponentLoader _loader;

  TheaterListViewModel get _viewModel => TheaterListViewModel.fromStore(_store);
  Theater get currentTheater => _viewModel.currentTheater;

  @ViewChild('menuContainer', read: ViewContainerRef)
  ViewContainerRef menuContainer;

  TheaterDropdownController _menuController;
  bool get theaterDropdownVisible =>
      _menuController != null && _menuController.isDestroyed == false;

  void toggleMenu() async {
    if (!theaterDropdownVisible) {
      _menuController = await TheaterDropdownController.loadAndShow(
        _loader,
        menuContainer,
      );
    } else {
      hideMenu();
    }
  }

  void hideMenu() {
    _menuController.hideAndDestroy();
    _menuController = null;
  }
}
