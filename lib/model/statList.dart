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
  @HiveField(3)
  final Map<String, int> histPro;

  NewList(this.recette, this.gain, this.dateNow, this.histPro);
}
