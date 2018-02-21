import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/ui/main_page.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app_state.dart';
import 'package:inkino/redux/store.dart';
import 'package:redux/redux.dart';

void main() => runApp(new InKinoApp());

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
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: new MaterialColor(0xFF1C306D, <int, Color>{
            50: const Color(0xFFE4E6ED),
            100: const Color(0xFFBBC1D3),
            200: const Color(0xFF8E98B6),
            300: const Color(0xFF606E99),
            400: const Color(0xFF3E4F83),
            500: const Color(0xFF1C306D),
            600: const Color(0xFF192B65),
            700: const Color(0xFF14245A),
            800: const Color(0xFF111E50),
            900: const Color(0xFF09133E),
          }),
          accentColor: new Color(0xFFFFAD32),
        ),
        home: new MyHomePage(),
      ),
    );
  }
}