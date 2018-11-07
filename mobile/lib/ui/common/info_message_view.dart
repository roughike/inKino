import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/message_provider.dart';
import 'package:meta/meta.dart';

class ErrorView extends InfoMessageView {
  static const Key tryAgainButtonKey = Key('tryAgainButton');

  const ErrorView({
    String title,
    String description,
    @required VoidCallback onRetry,
  }) : super(
          actionButtonKey: tryAgainButtonKey,
          title: title,
          description: description,
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

  final String title;
  final String description;
  final Key actionButtonKey;
  final VoidCallback onActionButtonTapped;

  List<Widget> _buildContent(Messages messages) => [
        const CircleAvatar(
          child: Icon(
            Icons.info_outline,
            color: Colors.white70,
            size: 52.0,
          ),
          backgroundColor: Colors.white12,
          radius: 42.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          title ?? messages.oops,
          style: const TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Text(
          description ?? messages.loadingMoviesError,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    final content = _buildContent(messages);

    if (onActionButtonTapped != null) {
      content.add(_ActionButton(
        actionButtonKey,
        onActionButtonTapped,
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

class _ActionButton extends StatelessWidget {
  _ActionButton(Key key, this.onActionButtonTapped) : super(key: key);
  final VoidCallback onActionButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: FlatButton(
        onPressed: onActionButtonTapped,
        child: Text(
          MessageProvider.of(context).tryAgain,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
