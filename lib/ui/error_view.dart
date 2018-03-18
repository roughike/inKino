import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ErrorView extends StatelessWidget {
  ErrorView({
    this.title,
    this.description,
    @required this.onRetry,
  });

  final String title;
  final String description;
  final VoidCallback onRetry;

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
                title ?? 'Oops!',
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                description ?? 'There was an error while\nloading movies.',
                textAlign: TextAlign.center,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: new FlatButton(
                onPressed: onRetry,
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
