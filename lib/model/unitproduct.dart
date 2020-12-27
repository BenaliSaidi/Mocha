import 'package:hive/hive.dart';

part 'unitproduct.g.dart';

@HiveType(typeId: 4)
class Unit {
  @HiveField(0)
  final String product ;

  @HiveField(1)
  final int unite ;

  Unit(this.product , this.unite);

 @override
  String toString() {
    return super.toString();
  }
}