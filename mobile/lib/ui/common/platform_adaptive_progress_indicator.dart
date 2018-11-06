import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAdaptiveProgressIndicator extends StatelessWidget {
  const PlatformAdaptiveProgressIndicator() : super();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
