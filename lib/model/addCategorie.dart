import 'package:hive/hive.dart';
part 'addCategorie.g.dart';

@HiveType(typeId: 9)
class Categorie {
  @HiveField(1)
  final String categorie;

  Categorie(this.categorie);
}
