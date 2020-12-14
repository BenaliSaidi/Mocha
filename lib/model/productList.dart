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

  NewProduct(this.name, this.buyingPrice, this.sellingPrice);
}