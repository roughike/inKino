import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:web/src/common/content_rating/content_rating_component.dart';

@Component(
  selector: 'showtime-item',
  styleUrls: ['showtime_item_component.css'],
  templateUrl: 'showtime_item_component.html',
  directives: [ContentRatingComponent, NgIf, NgFor],
  pipes: [DatePipe],
)
class ShowtimeItemComponent {
  ShowtimeItemComponent(this.messages);
  final Messages messages;

  @Input()
  Show show;

  void openTickets(html.Event event) {
    html.window.open(show.url, 'Tickets for ${show.title}');
    event.stopImmediatePropagation();
  }
}
