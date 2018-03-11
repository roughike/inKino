import 'package:flutter/material.dart';

class ShowtimeDateSelector extends StatefulWidget {
  @override
  _ShowtimeDateSelectorState createState() => new _ShowtimeDateSelectorState();
}

class _ShowtimeDateSelectorState extends State<ShowtimeDateSelector> {
  int _selectedIndex = 0;

  Widget _buildDateItem(int myIndex) {
    var color = _selectedIndex == myIndex
        ? Colors.white
        : Colors.white.withOpacity(0.4);

    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = myIndex;
          });
        },
        radius: 56.0,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Sun',
                style: new TextStyle(
                  fontSize: 12.0,
                  color: color,
                ),
              ),
              new Text(
                '11',
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      color: const Color(0xFF222222),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return _buildDateItem(index);
        },
      ),
    );
  }
}
