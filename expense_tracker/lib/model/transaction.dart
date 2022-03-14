// import 'package:hive/hive.dart';

// part 'transaction.g.dart';

// @HiveType(typeId: 0)
// class Transaction extends HiveObject {
class Transaction {
  // // @HiveField(0)
  // late String name;

  // // @HiveField(1)
  // late DateTime createdDate;

  // // @HiveField(2)
  // late bool isExpense = true;

  // // @HiveField(3)
  // late double amount;

  final String id;
  final String title;
  final DateTime date;
  final double amount;

  const Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
  });
}
