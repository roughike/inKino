import 'package:meta/meta.dart';

class Actor {
  Actor({
    @required this.name,
    this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}
