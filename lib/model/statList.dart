import 'package:hive/hive.dart';

part 'statList.g.dart';

@HiveType(typeId: 1)
class NewList {
  @HiveField(0)
  final int recette;
  @HiveField(1)
  final int gain;
  @HiveField(2)
  final String dateNow;

  NewList(this.recette, this.gain, this.dateNow );
}