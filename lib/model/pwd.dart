import 'package:hive/hive.dart';
part 'pwd.g.dart';

@HiveType(typeId: 12)
class PassWord {
  @HiveField(1)
  final String pwd;

  PassWord(this.pwd);
}
