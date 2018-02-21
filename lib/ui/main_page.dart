import 'package:flutter/material.dart';
import 'package:inkino/ui/movie_grid.dart';
import 'package:inkino/ui/showtimes/showtimes_page.dart';
import 'package:inkino/ui/theater_list/theater_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static final List<Object> movieList = new List.generate(100, (_) => '');

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  Widget _buildDrawer() {
    var textTheme = Theme.of(context).textTheme;
    var drawerHeader = new Container(
      color: Theme.of(context).primaryColor,
      constraints: new BoxConstraints.expand(height: 175.0),
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(
            'inKino',
            style: textTheme.display1.copyWith(color: Colors.white70),
          ),
          new Text(
            'v1.0.0',
            style: textTheme.body2.copyWith(color: Colors.white),
          ),
        ],
      ),
    );

    return new Drawer(child: new TheaterList(drawerHeader));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('TODO'),
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Tab>[
            new Tab(text: 'Showtimes'),
            new Tab(text: 'Now in theaters'),
            new Tab(text: 'Coming soon'),
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new ShowtimesPage(),
          new MovieGrid(movieList),
          new MovieGrid(movieList),
        ],
      ),
    );
  }
}
