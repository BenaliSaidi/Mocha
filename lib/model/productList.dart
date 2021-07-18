import 'package:hive/hive.dart';

part 'productList.g.dart';

@HiveType(typeId: 0)
class NewProduct {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int buyingPrice;
  @HiveField(2)
  final int sellingPrice;
  @HiveField(3)
  final int benefit;

  NewProduct(this.name, this.buyingPrice, this.sellingPrice, this.benefit);
}
