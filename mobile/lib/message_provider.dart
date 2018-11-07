import 'dart:async';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageProvider {
  MessageProvider(this.messages);
  final Messages messages;

  static Future<MessageProvider> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return MessageProvider(Messages());
    });
  }

  static Messages of(BuildContext context) {
    return Localizations.of<MessageProvider>(context, MessageProvider).messages;
  }
}

class InKinoLocalizationsDelegate
    extends LocalizationsDelegate<MessageProvider> {
  const InKinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fi'].contains(locale.languageCode);

  @override
  Future<MessageProvider> load(Locale locale) => MessageProvider.load(locale);

  @override
  bool shouldReload(InKinoLocalizationsDelegate old) => false;
}
