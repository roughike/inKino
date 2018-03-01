import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircleAvatar(
              child: new Icon(
                Icons.info_outline,
                color: Colors.black54,
                size: 52.0,
              ),
              backgroundColor: Colors.black12,
              radius: 42.0,
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: new Text(
                'Oops!',
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                'There was an error while\nloading movies.',
                textAlign: TextAlign.center,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: new FlatButton(
                onPressed: () {},
                child: new Text(
                  'TRY AGAIN',
                  style: new TextStyle(color: theme.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
