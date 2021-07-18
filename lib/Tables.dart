import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:mocha/model/tableList.dart';
import 'package:toast/toast.dart';

import 'UnitProduct.dart';
import 'counterEvening.dart';
import 'model/statList.dart';

Size displaySize(BuildContext context) {
  print('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  print('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  print('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

List<int> totalprices = [];
List<int> totalbenefits = [];
Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);
Color colorTable = Colors.teal;

// ignore: non_constant_identifier_names

void addNewEveningStat(NewList stat) {
  Hive.openBox('statEvening');
  final statBox = Hive.box('statEvening');
  statBox.add(stat);
}

timeNow() {
  return newFormat.format(DateTime.now());
}

calculateTotalPrice() {
  final totalpricesList = Hive.box('Paidproduct').values.toList();

  totalprices.clear();
  if (totalprices.isEmpty) {
    totalprices.add(0);
  }
  totalpricesList.forEach((item) => totalprices.add(item.sellingPrice));
  //print(prices);
  int sumTP = totalprices.reduce((a, b) => a + b);
  print('sum pf slg $sumTP');
  return sumTP;
}

calculateTotalBenefit() {
  final totalbenefitList = Hive.box('Paidproduct').values.toList();
  totalbenefits.clear();
  if (totalbenefits.isEmpty) {
    totalbenefits.add(0);
  }
  totalbenefitList.forEach((item) => totalbenefits.add(item.benefit));

  int sumTB = totalbenefits.reduce((c, d) => c + d);
  print('sum pf b $sumTB');
  return sumTB;
}

void main() => runApp(MaterialApp(home: Tables()));

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final _formKey = GlobalKey<FormState>();
  String name;

  void addNewTable(Tableslist table) {
    final tableBox = Hive.box('table');
    tableBox.add(table);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CounterEvening(value: '00'),
                        ));
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.teal[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Comptoir',
                      style: TextStyle(fontSize: displayWidth(context) * 0.08),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
                valueListenable: Hive.box('table').listenable(),
                builder: (context, box, widget) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                      height: 300,
                      child: GridView.count(
                        primary: false,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 4,
                        children:
                            List.generate(Hive.box('table').length, (index) {
                          final table =
                              Hive.box('table').getAt(index) as Tableslist;
                          return RaisedButton(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Text(
                                                'Voulez vous vraiment supprimer cette table'),
                                            OutlinedButton(
                                                onPressed: () {
                                                  Hive.box('table')
                                                      .deleteAt(index);
                                                  Toast.show(
                                                      "table supprimée avec succès",
                                                      context,
                                                      duration: 1,
                                                      gravity: Toast.BOTTOM,
                                                      textColor:
                                                          Color(0xFF66FCF1));
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OUI'))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            splashColor: Color(0xFF45A29E),
                            color: Colors.teal[300],
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CounterEvening(value: table.name),
                                  ));
                            },
                            child: Text(
                              table.name,
                              style: TextStyle(
                                  fontSize: displayWidth(context) * 0.08,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ));
                }),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          if (Hive.box('Paidproduct').isEmpty) {
                            print('veuillez d\'abord cloturer les tables SVP ');
                            if (Hive.box('order').isNotEmpty) {
                              print(
                                  'veuillez d\'abord cloturer les tables SVP ');
                            }
                            Toast.show("veuillez d\'abord cloturer les tables ",
                                context,
                                duration: 1,
                                gravity: Toast.CENTER,
                                textColor: Color(0xFF66FCF1));
                          } else {
                            print(Hive.box('Paidproduct').length);

                            final recette = NewList(calculateTotalPrice(),
                                calculateTotalBenefit(), timeNow());
                            var a = recette.recette;
                            var b = recette.gain;
                            print('recette $a');
                            print('gain $b');
                            print(recette.dateNow);

                            addNewEveningStat(recette);
                            Hive.box('order').clear();
                            Hive.box('Paidproduct').clear();
                            Toast.show(
                                "Bravo vous avez clôturé la journée", context,
                                duration: 1,
                                gravity: Toast.CENTER,
                                textColor: Color(0xFF66FCF1));
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            'Cloturer la journée',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UnitProduct()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                          child: Icon(Icons.list),
                        )),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: buttoncolor,
          child: Text(
            '+',
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Veuillez Inserer svp le nom de la table'),
                                SizedBox(
                                  height: 50,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: buttoncolor,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white10,
                                    labelText: 'Nom',
                                    labelStyle: TextStyle(
                                        color: buttoncolor, fontSize: 13),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          width: 2, color: buttoncolor),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'SVP entrez un nom valide';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => name = value,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                RaisedButton(
                                  color: buttoncolor,
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      final newtable = Tableslist(
                                        name,
                                      );
                                      addNewTable(newtable);
                                      _formKey.currentState.reset();
                                      Toast.show("table sauvegardé avec succès",
                                          context,
                                          duration: 1,
                                          gravity: Toast.BOTTOM,
                                          textColor: Color(0xFF66FCF1));
                                    }
                                  },
                                  child: Text('Sauvegarder',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: backgroundcolor)),
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
