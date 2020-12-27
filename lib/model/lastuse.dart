import 'package:hive/hive.dart';

part 'lastuse.g.dart';

@HiveType(typeId: 3)
class LastDate {
  @HiveField(0)
  final DateTime lastuse ;

  LastDate(this.lastuse);
}