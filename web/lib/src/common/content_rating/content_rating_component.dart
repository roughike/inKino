import 'package:angular/angular.dart';
import 'package:core/core.dart';

@Component(
  selector: 'content-rating',
  templateUrl: 'content_rating_component.html',
  styleUrls: ['content_rating_component.css'],
  directives: [NgFor],
)
class ContentRatingComponent {
  @Input()
  Show show;

  @Input()
  Event event;

  String get ageRating => show?.ageRating ?? event?.ageRating;
  String get ageRatingUrl => show?.ageRatingUrl ?? event?.ageRatingUrl;

  List<ContentDescriptor> get contentDescriptors =>
      show?.contentDescriptors ?? event?.contentDescriptors;
}
