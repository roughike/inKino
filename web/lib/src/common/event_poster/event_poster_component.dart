import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:web/src/common/content_rating/content_rating_component.dart';
import 'package:web/src/common/event_poster/lazy_image_component.dart';

@Component(
  selector: 'event-poster',
  styleUrls: ['event_poster_component.css'],
  templateUrl: 'event_poster_component.html',
  directives: [
    ContentRatingComponent,
    LazyImageComponent,
    NgIf,
    NgFor,
  ],
)
class EventPosterComponent {
  static final _releaseDateFormat = DateFormat('dd.MM.yyyy');

  EventPosterComponent(this.messages);
  final Messages messages;

  @Input()
  Event event;

  @Input()
  bool isComingSoon = false;

  @Input()
  bool hasDetails = true;

  @Input()
  bool isTouchable = true;

  String get releaseDate => _releaseDateFormat.format(event.releaseDate);
}
