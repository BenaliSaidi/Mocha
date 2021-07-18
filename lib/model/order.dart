import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 6)
class NewOrder {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int buyingPrice;
  @HiveField(2)
  final int sellingPrice;
  @HiveField(3)
  final int benefit;
  @HiveField(4)
  final String tables;
  @HiveField(5)
  final int key;

  NewOrder(this.name, this.buyingPrice, this.sellingPrice, this.benefit,
      this.tables, this.key);
}
