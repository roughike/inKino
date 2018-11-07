import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:web/src/routes.dart';

@Component(
  selector: 'nav-bar',
  templateUrl: 'nav_bar_component.html',
  styleUrls: ['nav_bar_component.css'],
  directives: [
    routerDirectives,
  ],
  exports: [RoutePaths],
)
class NavBarComponent {
  NavBarComponent(this.messages);
  final Messages messages;

  @Input()
  bool theaterDropdownActive = false;
}
