import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:web/src/event_details/actor_scroller/actor_image_component.dart';

@Component(
  selector: 'actor-scroller',
  templateUrl: 'actor_scroller_component.html',
  styleUrls: ['actor_scroller_component.css'],
  directives: [ActorImageComponent, NgFor],
)
class ActorScrollerComponent {
  @Input()
  List<Actor> actors;
}
