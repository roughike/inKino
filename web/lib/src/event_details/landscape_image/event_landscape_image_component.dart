import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:core/core.dart';

@Component(
  selector: 'event-landscape-image',
  templateUrl: 'event_landscape_image_component.html',
  styleUrls: ['event_landscape_image_component.css'],
)
class EventLandscapeImageComponent implements OnInit, OnDestroy {
  @Input()
  Event event;

  @ViewChild('actualImage')
  html.ImageElement imageElement;

  bool _triedWithSecondLandscapeUrl = false;

  @override
  void ngOnInit() {
    imageElement.addEventListener('load', _onLoad);
    imageElement.addEventListener('error', _onError);
  }

  @override
  void ngOnDestroy() => _clearListeners();

  void _onLoad(html.Event _) {
    imageElement.classes.add('loaded');
    _clearListeners();
  }

  void _onError(html.Event _) {
    if (_triedWithSecondLandscapeUrl) {
      _clearListeners();
      return;
    }

    imageElement.src = event.images.landscapeHd2;
    _triedWithSecondLandscapeUrl = true;
  }

  void _clearListeners() {
    imageElement.removeEventListener('load', _onLoad);
    imageElement.removeEventListener('error', _onError);
  }
}
