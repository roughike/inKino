import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class InKinoDrawerHeader extends StatefulWidget {
  const InKinoDrawerHeader();

  @override
  _InKinoDrawerHeaderState createState() => _InKinoDrawerHeaderState();
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
    _flutterTapRecognizer = TapGestureRecognizer()
      ..onTap = () => _openUrl(flutterUrl);
    _githubTapRecognizer = TapGestureRecognizer()
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'inKino',
            style: textTheme.display1.copyWith(color: Colors.white70),
          ),
          Text(
            'v1.0.1', // TODO: figure out a way to get this dynamically
            style: textTheme.body2.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Icon(
          Icons.info_outline,
          color: Colors.white70,
          size: 18.0,
        ),
        const SizedBox(width: 8.0),
        const Text(
          'About',
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
          ),
        ),
      ],
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDialog<Null>(
            context: context,
            builder: (BuildContext context) => _buildAboutDialog(context),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('About inKino'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
          const SizedBox(height: 16.0),
          _buildTMDBAttribution(),
        ],
      ),
      actions: <Widget>[
        FlatButton(
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
    return RichText(
      text: TextSpan(
        text: 'inKino is the unofficial Finnkino client that '
            'is minimalistic, fast, and delightful to use.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'The app was developed with '),
          TextSpan(
            text: 'Flutter',
            recognizer: _flutterTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          TextSpan(
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
    return Row(
      children: <Widget>[
        Image.asset(
          ImageAssets.poweredByTMDBLogo,
          width: 32.0,
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Text(
            'This product uses the TMDb API but is not endorsed or certified by TMDb.',
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      constraints: const BoxConstraints.expand(height: 175.0),
      child: Row(
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
