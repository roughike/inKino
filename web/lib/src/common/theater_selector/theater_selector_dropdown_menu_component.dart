import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:web/src/common/theater_selector/theater_dropdown_controller.dart';

@Component(
  selector: 'theater-selector-dropdown-menu',
  templateUrl: 'theater_selector_dropdown_menu_component.html',
  styleUrls: ['theater_selector_dropdown_menu_component.css'],
  directives: [NgFor],
)
class TheaterSelectorDropdownMenuComponent {
  TheaterSelectorDropdownMenuComponent(this._store);
  final Store<AppState> _store;

  TheaterDropdownController controller;
  String background;

  TheaterListViewModel get _viewModel => TheaterListViewModel.fromStore(_store);
  Theater get selectedTheater => _viewModel.currentTheater;
  List<Theater> get theaters => _viewModel.theaters.list;

  bool get focusTrapVisible => isOpen;
  bool isOpen = false;

  void onTheaterClicked(Theater newTheater) {
    _viewModel.changeCurrentTheater(newTheater);
    controller.hideAndDestroy();
  }

  void hideAndDestroy() => controller.hideAndDestroy();
}
