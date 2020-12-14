import 'package:flutter/material.dart';
import 'package:mocha/home.dart';
import 'package:mocha/addnewproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/productList.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NewProductAdapter());
  final box = await Hive.openBox('product');

  runApp(MaterialApp(

    initialRoute: '/home' ,
    routes: {
      '/home' : (context) => Home(),
      '/addnewproduct' : (context) => AddProduct(),
    },
  ),
  );
}


