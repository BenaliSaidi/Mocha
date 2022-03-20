import 'package:hive/hive.dart';
part 'deletedProduct.g.dart';

@HiveType(typeId: 14)
class DelProduct {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int price;

  @HiveField(2)
  final String table;

  @HiveField(3)
  final String date;

  DelProduct(this.name, this.price, this.table, this.date);
}
