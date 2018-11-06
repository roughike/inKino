import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'actor-img',
  templateUrl: 'actor_image_component.html',
  styleUrls: ['actor_image_component.css'],
)
class ActorImageComponent implements OnInit {
  @Input()
  String src;

  @ViewChild('actualImage')
  ImageElement imageElement;

  @override
  void ngOnInit() {
    imageElement.addEventListener(
        'load', (_) => imageElement.classes.add('loaded'));
  }
}
