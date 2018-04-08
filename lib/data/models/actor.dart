import 'package:meta/meta.dart';

class Actor {
  Actor({
    @required this.name,
    this.avatarUrl,
  });

  final String name;
  final String avatarUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Actor &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              avatarUrl == other.avatarUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      avatarUrl.hashCode;
}
