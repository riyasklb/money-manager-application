import 'package:hive/hive.dart';
import 'package:pj1/models/catogories/catogories_model.dart';
part 'transactions_ model.g.dart';

@HiveType(typeId: 3)
class transactionmodel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final categorytype type;

  @HiveField(4)
  final categorymodel category;

  @HiveField(5)
  String? id;

  transactionmodel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    // required this.id,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
