import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:mocha/delProduct.dart';
import 'package:mocha/model/TotalUnitProduct.dart';
import 'package:mocha/model/tableList.dart';
import 'package:mocha/paidTable.dart';
import 'package:mocha/unitProMor.dart';
import 'package:toast/toast.dart';
import 'counterMorning.dart';
import 'model/statList.dart';

Size displaySize(BuildContext context) {
  print('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

List<int> totalprices = [];
List<int> totalbenefits = [];
Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);
Color colorTable;
var size = 0;

String pass;
String psw;

String mdp() {
  if (Hive.box('password').isNotEmpty) {
    psw = Hive.box('password').getAt(0).pwd;
  } else {
    psw = 'admin';
  }
  return psw;
}

void addNewMorningStat(NewList stat) {
  Hive.openBox('statMorning');
  final statBox = Hive.box('statMorning');
  statBox.add(stat);
}

timeNow() {
  return newFormat.format(DateTime.now());
}

void deletedProduct() {
  Hive.box('deletedProduct').clear();
}

int sumTP;
calculateTotalPrice() {
  final totalpricesList = Hive.box('Paidproduct').values.toList();

  totalprices.clear();
  if (totalprices.isEmpty) {
    totalprices.add(0);
  }
  totalpricesList.forEach((item) => totalprices.add(item.sellingPrice));
  //print(prices);
  sumTP = totalprices.reduce((a, b) => a + b);
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

class TablesMorning extends StatefulWidget {
  @override
  _TablesMorningState createState() => _TablesMorningState();
}

class _TablesMorningState extends State<TablesMorning> {
  final _formKey = GlobalKey<FormState>();
  String name;

  Color tableColor(tableNum) {
    var size = Hive.box('order')
        .values
        .where((order) => order.tables == tableNum)
        .toList()
        .length;
    if (size == 0) {
      colorTable = Color(0xFF607D8B);
    } else {
      colorTable = Colors.red[400];
    }
    return colorTable;
  }

  int gridViewlayout() {
    if (displaySize(context).width < 400) {
      row = 4;
    } else if (400 < displaySize(context).width &&
        800 > displaySize(context).width) {
      row = 6;
    } else {
      row = 8;
    }
    return row;
  }

  double fontsize() {
    if (displaySize(context).width < 400) {
      font = 16;
    } else if (400 < displaySize(context).width &&
        800 > displaySize(context).width) {
      font = 20;
    } else {
      font = 23;
    }
    return font;
  }

  void addNewTable(Tableslist table) {
    final tableBox = Hive.box('table');
    tableBox.add(table);
  }

  @override
  Widget build(BuildContext context) {
    mdp();
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'MatiN',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF455A64),
      ),
      body: Column(
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
                        builder: (context) => CounterMorning(value: '00'),
                      ));
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(0xFF455A64),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Comptoir',
                    style: TextStyle(
                      fontSize: fontsize(),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: ValueListenableBuilder(
                valueListenable: Hive.box('order').listenable(),
                builder: (context, box, widget) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                      height: 300,
                      child: GridView.count(
                        primary: false,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: gridViewlayout(),
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
                                                  setState(() {});
                                                },
                                                child: Text('OUI'))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            splashColor: Color(0xFF45A29E),
                            color: tableColor(table.name),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CounterMorning(value: table.name),
                                  ));
                            },
                            child: Text(
                              table.name,
                              style: TextStyle(
                                fontSize: fontsize(),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ));
                }),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
              child: Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, top: 20),
                                        child: Text(
                                            'Voulez vous vraiment clôturer la journée ?'),
                                      ),
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                          ),
                                          onPressed: () {
                                            if (Hive.box('Paidproduct')
                                                .isEmpty) {
                                              print(
                                                  'veuillez d\'abord clôturer les tables SVP ');
                                              if (Hive.box('order')
                                                  .isNotEmpty) {
                                                print(
                                                    'veuillez d\'abord clôturer les tables SVP ');
                                              }
                                              Toast.show(
                                                  "veuillez d\'abord clôturer les tables ",
                                                  context,
                                                  duration: 1,
                                                  gravity: Toast.CENTER,
                                                  textColor: Color(0xFF66FCF1));
                                            } else {
                                              void addNewUnit(
                                                  TotalUnit totalunit) {
                                                final statBox = Hive.box(
                                                    'TotalunitMorning');
                                                statBox.add(totalunit);
                                              }

                                              Map<String, int> bigmap = {};
                                              RetrieveUnit() {
                                                unites.clear();
                                                var totalproductList =
                                                    Hive.box('Paidproduct')
                                                        .values
                                                        .toList();
                                                totalproductList.forEach(
                                                    (i) => unites.add(i.name));
                                                unites.forEach((element) {
                                                  if (!bigmap
                                                      .containsKey(element)) {
                                                    bigmap[element] = 1;
                                                  } else {
                                                    bigmap[element] += 1;
                                                  }
                                                });

                                                bigmap.forEach((k, v) {
                                                  final listeTotalUnit =
                                                      TotalUnit(k, v);
                                                  addNewUnit(listeTotalUnit);
                                                });
                                              }

                                              RetrieveUnit();
                                              print(bigmap);

                                              final recette = NewList(
                                                  calculateTotalPrice(),
                                                  calculateTotalBenefit(),
                                                  timeNow(),
                                                  bigmap);

                                              addNewMorningStat(recette);

                                              Hive.box('Paidproduct').clear();
                                              Hive.box('history').clear();
                                              deletedProduct();

                                              Toast.show(
                                                  "Bravo vous avez clôturé la journée",
                                                  context,
                                                  duration: 1,
                                                  gravity: Toast.BOTTOM,
                                                  textColor: Colors.white);
                                            }
                                          },
                                          child: Text(
                                            'OUI',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF455A64),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          'Clôturer la journée',
                          style: TextStyle(
                              fontSize: fontsize(), color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TablePaid()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF455A64),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          'Table Clôturée',
                          style: TextStyle(
                              fontSize: fontsize(), color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  height: 200,
                                  width: 200,
                                  padding: EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              obscureText: true,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                //fontSize: 20,
                                                color: buttoncolor,
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white10,
                                                labelText: 'Password',
                                                labelStyle: TextStyle(
                                                    color: buttoncolor,
                                                    fontSize: 13),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: buttoncolor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onSaved: (value) => pass = value,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'SVP INSEREZ UN MDP VALIDE';
                                                }
                                                if (value != psw) {
                                                  return 'SVP INSEREZ UN MDP VALIDE';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 30),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                buttoncolor)),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UnitProMor()),
                                                    );
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30, right: 30),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 13.0,
                                                            bottom: 13),
                                                    child: Text(
                                                      '   vers statistiques   ',
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color(0xFF455A64),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Icon(Icons.list),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  height: 200,
                                  width: 200,
                                  padding: EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              obscureText: true,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                color: buttoncolor,
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white10,
                                                labelText: 'Password',
                                                labelStyle: TextStyle(
                                                    color: buttoncolor,
                                                    fontSize: 13),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: buttoncolor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              onSaved: (value) => pass = value,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'SVP INSEREZ UN MDP VALIDE';
                                                }
                                                if (value != psw) {
                                                  return 'SVP INSEREZ UN MDP VALIDE';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 30),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                buttoncolor)),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              delProducts()),
                                                    );
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30, right: 30),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 13.0,
                                                            bottom: 13),
                                                    child: Center(
                                                      child: Text(
                                                        'Valider',
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color(0xFF455A64),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Icon(Icons.delete),
                      )),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF455A64),
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
                                      setState(() {});
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