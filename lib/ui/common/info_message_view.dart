import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ErrorView extends InfoMessageView {
  static const Key tryAgainButtonKey = Key('tryAgainButton');

  const ErrorView({
    String title,
    String description,
    @required VoidCallback onRetry,
  }) : super(
          actionButtonKey: tryAgainButtonKey,
          title: title ?? 'Oops!',
          description:
              description ?? 'There was an error while\nloading movies.',
          onActionButtonTapped: onRetry,
        );
}

class InfoMessageView extends StatelessWidget {
  const InfoMessageView({
    Key key,
    @required this.title,
    @required this.description,
    this.actionButtonKey,
    this.onActionButtonTapped,
  }) : super(key: key);

  final Key actionButtonKey;
  final String title;
  final String description;
  final VoidCallback onActionButtonTapped;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var content = <Widget>[
      const CircleAvatar(
        child: Icon(
          Icons.info_outline,
          color: Colors.black54,
          size: 52.0,
        ),
        backgroundColor: Colors.black12,
        radius: 42.0,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          description,
          textAlign: TextAlign.center,
        ),
      ),
    ];

    if (onActionButtonTapped != null) {
      content.add(Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: FlatButton(
          key: actionButtonKey,
          onPressed: onActionButtonTapped,
          child: Text(
            'TRY AGAIN',
            style: TextStyle(color: theme.primaryColor),
          ),
        ),
      ));
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          ),
        ),
      ),
    );
  }
}
