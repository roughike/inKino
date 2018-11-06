import 'package:flutter/widgets.dart';

void addIfNonNull(Widget widget, List<Widget> children) {
  if (widget != null) {
    children.add(widget);
  }
}
