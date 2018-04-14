import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class InKinoDrawerHeader extends StatefulWidget {
  const InKinoDrawerHeader();

  @override
  _InKinoDrawerHeaderState createState() => new _InKinoDrawerHeaderState();
}

class _InKinoDrawerHeaderState extends State<InKinoDrawerHeader> {
  static const String flutterUrl = 'https://flutter.io/';
  static const String githubUrl = 'https://github.com/roughike/inKino';
  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  TapGestureRecognizer _flutterTapRecognizer;
  TapGestureRecognizer _githubTapRecognizer;

  @override
  void initState() {
    super.initState();
    _flutterTapRecognizer = new TapGestureRecognizer()
      ..onTap = () => _openUrl(flutterUrl);
    _githubTapRecognizer = new TapGestureRecognizer()
      ..onTap = () => _openUrl(githubUrl);
  }

  @override
  void dispose() {
    _flutterTapRecognizer.dispose();
    _githubTapRecognizer.dispose();
    super.dispose();
  }

  void _openUrl(String url) async {
    // Close the about dialog.
    Navigator.pop(context);

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildAppNameAndVersion(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Padding(
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
            'v1.0.1', // TODO: figure out a way to get this dynamically
            style: textTheme.body2.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    var content = new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Icon(
          Icons.info_outline,
          color: Colors.white70,
          size: 18.0,
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: const Text(
            'About',
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );

    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildAboutDialog(context),
          );
        },
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('About inKino'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
          _buildTMDBAttribution(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text: 'inKino is the unofficial Finnkino client that '
            'is minimalistic, fast, and delightful to use.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'The app was developed with '),
          new TextSpan(
            text: 'Flutter',
            recognizer: _flutterTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          new TextSpan(
            text: 'the GitHub repo',
            recognizer: _githubTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildTMDBAttribution() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Image.asset(
              ImageAssets.poweredByTMDBLogo,
              width: 32.0,
            ),
          ),
          const Expanded(
            child: const Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: const Text(
                'This product uses the TMDb API but is not endorsed or certified by TMDb.',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).primaryColor,
      constraints: const BoxConstraints.expand(height: 175.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildAppNameAndVersion(context),
          _buildAboutButton(context),
        ],
      ),
    );
  }
}
