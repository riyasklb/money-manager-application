import 'package:hive/hive.dart';
part 'catogories_model.g.dart';

@HiveType(typeId: 1)
class categorymodel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isdeleted;

  @HiveField(2)
  final categorytype type;

  @HiveField(3)
  final String id;

  categorymodel({
    required this.id,
    required this.name,
    this.isdeleted = false,
    required this.type,
  });
  @override
  String toString() {
    return '{$name $type}';
  }
}

@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,

  @HiveField(1)
  expence,
}
