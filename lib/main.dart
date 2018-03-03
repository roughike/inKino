import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/ui/main_page.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/store.dart';
import 'package:redux/redux.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = true;

  runApp(new InKinoApp());
}

class InKinoApp extends StatefulWidget {
  final Store<AppState> store = createStore();

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
        home: new MyHomePage(),
      ),
    );
  }
}
