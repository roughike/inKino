import 'package:meta/meta.dart';

class Theater {
  Theater({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Theater &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
