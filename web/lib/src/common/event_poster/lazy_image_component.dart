import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

import 'package:angular/angular.dart';

final bool supportsIntersectionObserver =
    js.context.hasProperty('IntersectionObserver');

@Component(
  selector: 'lazy-img',
  template: '<img [attr.data-src]="src" class="lazy" [alt]="alt" />',
  styleUrls: ['lazy_image_component.css'],
)
class LazyImageComponent implements OnInit {
  static const _ratio = 2 / 3;
  static const _widthBreakpoints = [160, 206, 300];
  static int _adjustedWidth, _adjustedHeight;

  LazyImageComponent(this.root);
  final Element root;

  @Input()
  String src;

  @Input()
  String alt;

  /// So that the images can be also seen fading in when scrolling
  static final onLoad = (image) => Timer(
        const Duration(milliseconds: 50),
        () => image.style.opacity = '1',
      );

  static final _instance = IntersectionObserver(
    js.allowInterop((entries, observer) {
      entries.forEach((entry) {
        if (entry.isIntersecting && entry.target is ImageElement) {
          _loadImage(entry.target as ImageElement);
          observer.unobserve(entry.target);
        }
      });
    }),
  );

  static void _loadImage(ImageElement image, {String src}) {
    final url = src ?? image.dataset['src'];

    image
      ..src = _urlWithDimensions(url)
      ..classes.remove('lazy')
      ..addEventListener('load', (_) => onLoad(image))
      ..addEventListener('error', (_) => onLoad(image));
  }

  @override
  void ngOnInit() {
    final ImageElement image = root.querySelector('img');
    _calculateDimensionsIfNeeded(image);

    if (supportsIntersectionObserver) {
      _instance.observe(image);
    } else {
      /// No IntersectionObserver, tough luck, here's all of your 70 posters
      /// at once (╯°□°）╯︵ ┻━┻
      _loadImage(image, src: src);
    }
  }

  /// TODO: srcsets are probably the way to go instead.
  void _calculateDimensionsIfNeeded(ImageElement image) {
    if (_adjustedWidth == null || _adjustedHeight == null) {
      final clientWidth = image.clientWidth;

      if (clientWidth == null || clientWidth == 0) {
        _adjustedWidth = 300;
        _adjustedHeight = (_adjustedWidth / _ratio).round();
        return;
      }

      final closestWidth = _widthBreakpoints.firstWhere(
        (width) => width >= clientWidth,
        orElse: () => _widthBreakpoints.last,
      );

      _adjustedWidth = closestWidth;
      _adjustedHeight = (_adjustedWidth / _ratio).round();
    }
  }

  static String _urlWithDimensions(String url) {
    return '${url}&w=${_adjustedWidth}&h=${_adjustedHeight}';
  }
}
