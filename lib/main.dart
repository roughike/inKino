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
  runApp(InKinoApp(store));
}

class InKinoApp extends StatefulWidget {
  InKinoApp(this.store);
  final Store<AppState> store;

  @override
  _InKinoAppState createState() => _InKinoAppState();
}

class _InKinoAppState extends State<InKinoApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'inKino',
        theme: ThemeData(
          primaryColor: const Color(0xFF1C306D),
          accentColor: const Color(0xFFFFAD32),
        ),
        home: const MainPage(),
      ),
    );
  }
}
