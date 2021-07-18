import 'package:hive/hive.dart';

part 'paidproduct.g.dart';

@HiveType(typeId: 7)
class PaidProduct {
  @HiveField(0)
  final String name;
  @HiveField(2)
  final int sellingPrice;
  @HiveField(3)
  final int benefit;

  PaidProduct(this.name, this.sellingPrice, this.benefit);
}
