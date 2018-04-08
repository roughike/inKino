import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/store.dart';
import 'package:inkino/ui/main_page.dart';
import 'package:redux/redux.dart';

Future<Null> main() async {
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;

  var store = await createStore();
  runApp(new InKinoApp(store));
}

class InKinoApp extends StatefulWidget {
  InKinoApp(this.store);
  final Store<AppState> store;

  @override
  _InKinoAppState createState() => new _InKinoAppState();
}

class _InKinoAppState extends State<InKinoApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(new InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: widget.store,
      child: new MaterialApp(
        title: 'inKino',
        theme: new ThemeData(
          primaryColor: new Color(0xFF1C306D),
          accentColor: new Color(0xFFFFAD32),
        ),
        home: new MainPage(),
      ),
    );
  }
}
