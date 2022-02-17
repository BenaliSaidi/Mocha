import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mocha/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/addCategorie.dart';
import 'package:mocha/model/histTable.dart';
import 'package:mocha/model/productList.dart';
import 'package:mocha/model/pwd.dart';
import 'package:mocha/model/statList.dart';
import 'package:mocha/ActiveAccount.dart';
import 'package:mocha/TablesEvening.dart';
import 'package:mocha/model/endtime.dart';
import 'package:mocha/model/unitproduct.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'model/TotalUnitProduct.dart';
import 'model/lastuse.dart';
import 'model/order.dart';
import 'model/paidproduct.dart';
import 'model/tableList.dart';

void main() async {
  Hive.registerAdapter(HistTableAdapter());
  Hive.registerAdapter(NewListAdapter());
  Hive.registerAdapter(NewProductAdapter());
  Hive.registerAdapter(UnitAdapter());
  Hive.registerAdapter(TotalUnitAdapter());
  Hive.registerAdapter(PeriodAdapter());
  Hive.registerAdapter(LastDateAdapter());
  Hive.registerAdapter(TableslistAdapter());
  Hive.registerAdapter(NewOrderAdapter());
  Hive.registerAdapter(PaidProductAdapter());
  Hive.registerAdapter(CategorieAdapter());
  Hive.registerAdapter(PassWordAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  await Hive.openBox('Paidproduct');
  await Hive.openBox('product');
  await Hive.openBox('table');
  await Hive.openBox('counterMorning');
  await Hive.openBox('counterEvening');
  await Hive.openBox('statMorning');
  await Hive.openBox('statEvening');
  await Hive.openBox('unitMorning');
  await Hive.openBox('unitEvening');
  await Hive.openBox('period');
  await Hive.openBox('useperiod');
  await Hive.openBox('TotalunitMorning');
  await Hive.openBox('TotalunitEvening');
  await Hive.openBox('order');
  await Hive.openBox('categorie');
  await Hive.openBox('history');
  await Hive.openBox('password');

  var time = DateTime.now();
  // ignore: non_constant_identifier_names
  void FirstUse(LastDate last) {
    Hive.box('useperiod').put('lastTimeUse', last);
  }

  void addFirstPeriod(Period period) {
    Hive.box('period').put('time', period);
  }

  if (Hive.box('useperiod').isEmpty) {
    final lastuse = LastDate(time);
    FirstUse(lastuse);
  }

  // ignore: unrelated_type_equality_checks
  if (Hive.box('period').isEmpty) {
    final dateinit = time.add(Duration(days: 5));
    final firstperiod = Period(dateinit);
    addFirstPeriod(firstperiod);
  }
  var dateExp = Hive.box('period').get('time').endtime;
  var checkTime = Hive.box('useperiod').get('lastTimeUse').lastuse;

  if (DateTime.now().isAfter(checkTime) == true &&
      DateTime.now().isBefore(dateExp) == true) {
    Hive.box('useperiod').clear();
    final lastuse = LastDate(DateTime.now());
    FirstUse(lastuse);
    runApp(MaterialApp(home: Home()));
  } else {
    runApp(MaterialApp(home: ActiveAccount()));
  }
}
