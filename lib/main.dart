import 'package:flutter/material.dart';
import 'package:mocha/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/productList.dart';
import 'package:mocha/model/statList.dart';
import 'package:mocha/ActiveAccount.dart';
import 'package:mocha/model/endtime.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NewListAdapter());
  Hive.registerAdapter(NewProductAdapter());
  Hive.registerAdapter(PeriodAdapter());

  await Hive.openBox('product');
  await Hive.openBox('counterMorning');
  await Hive.openBox('counterEvening');
  await Hive.openBox('statMorning');
  await Hive.openBox('statEvening');
  await Hive.openBox('period');

// runApp(MaterialApp(home: Home(),));




    var test = Hive.box('period').get('time').endtime;

    if((DateTime.now().isAfter(test) == true)) {
      runApp(MaterialApp(home: ActiveAccount(),));
    }
    else{
      runApp(MaterialApp(home: Home(),));
    }





  // runApp(MaterialApp(
  //
  //   initialRoute: '/home' ,
  //   routes: {
  //     '/home' : (context) => Home(),
  //     '/addnewproduct' : (context) => AddProduct(),
  //     '/displayProductList' : (context) => productList(),
  //     '/CounterMenu' : (context) => CounterMenu(),
  //
  //   },
  // ),
  // );
}





