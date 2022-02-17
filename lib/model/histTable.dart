import 'package:hive/hive.dart';
part 'histTable.g.dart';

@HiveType(typeId: 11)
class HistTable {
  @HiveField(0)
  final int total;

  @HiveField(1)
  final String table;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final Map<int, String> valPrices;

  @HiveField(4)
  final Map<int, String> valNames;

  HistTable(this.total, this.table, this.date, this.valPrices, this.valNames);
}
