import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/ui/events/coming_soon_events_page.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/now_playing_events_page.dart';
import 'package:inkino/ui/showtimes/showtimes_page.dart';
import 'package:inkino/ui/theater_list/theater_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  TextEditingController _searchQuery;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    ModalRoute.of(context).addLocalHistoryEntry(new LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _searchQuery.clear();
          _isSearching = false;
        });
      },
    ));

    setState(() {
      _isSearching = true;
    });
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search movies...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: new TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (value) {
        var store = new StoreProvider.of(context).store;
        store.dispatch(new SearchQueryChangedAction(value));
      },
    );
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

    return new Drawer(
      child: new TheaterList(
        header: drawerHeader,
        onTheaterTapped: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: _isSearching ? new BackButton() : null,
        title: _isSearching ? _buildSearchField() : new Text('inKino'),
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Tab>[
            new Tab(text: 'Showtimes'),
            new Tab(text: 'Now in theaters'),
            new Tab(text: 'Coming soon'),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new ShowtimesPage(),
          new NowPlayingEventsPage(),
          new ComingSoonEventsPage(),
        ],
      ),
    );
  }
}
