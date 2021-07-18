import 'package:hive/hive.dart';

part 'TotalUnitProduct.g.dart';

@HiveType(typeId: 8)
class TotalUnit {
  @HiveField(0)
  final String product ;

  @HiveField(1)
  final int unite ;

  TotalUnit(this.product , this.unite);

 @override
  String toString() {
    return super.toString();
  }
}