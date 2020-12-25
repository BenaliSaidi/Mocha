import 'package:hive/hive.dart';

part 'endtime.g.dart';

@HiveType(typeId: 2)
class Period {
  @HiveField(0)
  final DateTime endtime ;

  Period(this.endtime);
}