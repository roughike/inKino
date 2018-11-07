import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
import 'package:key_value_store_web/key_value_store_web.dart';
import 'package:pwa/client.dart' as pwa;
import 'package:redux/redux.dart';
import 'package:web/app_component.template.dart' as ng;

import 'main.template.dart' as self;

final Store<AppState> _store = createStore(
  Client(),
  WebKeyValueStore(window.localStorage),
);
Store<AppState> storeFactory() => _store;

@GenerateInjector([
  const FactoryProvider(Store, storeFactory),
  const ClassProvider(Messages),
  routerProvidersHash,
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() async {
  pwa.Client();
  await _initializeTranslations();

  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}

void _initializeTranslations() async {
  var locale = await findSystemLocale();
  final initializationSuccessful = await initializeMessages(locale);
  await initializeDateFormatting(locale);

  if (!initializationSuccessful) {
    // If we can't initialize messages for current locale, fall back on English.
    locale = 'en';
    await initializeMessages(locale);
    await initializeDateFormatting(locale);
  }

  FinnkinoApi.useFinnish = locale == 'fi';
  Intl.defaultLocale = locale;
}
