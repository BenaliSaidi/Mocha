import 'package:hive/hive.dart';
part 'tableList.g.dart';

@HiveType(typeId: 5)
class Tableslist {
  @HiveField(0)
  final String name;

  Tableslist(this.name);
}
