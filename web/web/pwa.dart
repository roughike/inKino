import 'package:core/core.dart';
import 'package:pwa/worker.dart';

void main() {
  final cache = DynamicCache('inkino-cache', maxAge: const Duration(days: 1));

  Worker()
    ..offlineUrls = [
      './',
      './main.dart.js',
      './main.dart.js_1.part.js',
      './main.dart.js_2.part.js',
      './main.dart.js_3.part.js',
      './main.dart.js_4.part.js',
      './main.dart.js_5.part.js',
      './main.dart.js_6.part.js',
      './images/arrow_drop_down.svg',
      './images/back.svg',
      './images/background-image.jpg',
      './images/close.svg',
      './images/coming-soon.svg',
      './images/fallback-icon.svg',
      './images/favicon.png',
      './images/info.svg',
      './images/logo.png',
      './images/now-in-theaters.svg',
      './images/place.svg',
      './images/profile.svg',
      './images/search.svg',
      './images/showtimes.svg',
      './images/theaters.svg',
      './manifest.json',
    ]
    ..router.registerGetUrl(
        FinnkinoApi.enBaseUrl, (request) => cache.cacheFirst(request))
    ..router.registerGetUrl(
        FinnkinoApi.fiBaseUrl, (request) => cache.cacheFirst(request))
    ..run(version: '6');
}
