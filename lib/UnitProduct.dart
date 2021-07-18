import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/widgets.dart';

import 'package:toast/toast.dart';
import 'model/TotalUnitProduct.dart';

import 'model/unitproduct.dart';

List<dynamic> unites = [];
List<dynamic> productList = [];

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

void addNewUnit(TotalUnit totalunit) {
  final statBox = Hive.box('TotalunitEvening');
  statBox.add(totalunit);
}

RetrieveUnit() {
  var Bigmap = Map();
  unites.clear();
  var TotalproductList = Hive.box('Paidproduct').values.toList();
  TotalproductList.forEach((i) => unites.add(i.name));
  unites.forEach((element) {
    if (!Bigmap.containsKey(element)) {
      Bigmap[element] = 1;
    } else {
      Bigmap[element] += 1;
    }
  });
  //print(map);
  Bigmap.forEach((k, v) {
    final listeTotalUnit = TotalUnit(k, v);
    addNewUnit(listeTotalUnit);
  });
}

class UnitProduct extends StatefulWidget {
  const UnitProduct({Key key}) : super(key: key);

  @override
  _UnitProductState createState() => _UnitProductState();
}

class _UnitProductState extends State<UnitProduct> {
  @override
  Widget build(BuildContext context) {
    Hive.box('TotalunitEvening').clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniT',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[500],
      ),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: 50,
            child: ListTile(
              tileColor: Colors.teal[200],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 130,
                    child: Text('Article',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 60,
                    child: Text(
                      'Unités',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _buildListViewUnite()),
          ButtonTheme(
            splashColor: Color(0xFF45A29E),
            minWidth: double.infinity,
            height: 50,
            child: RaisedButton(
              color: Colors.teal[300],
              child: Text(
                'Actualiser',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              onPressed: () {
                setState(() {
                  if (Hive.box('Paidproduct').length == 0) {
                    Toast.show("Ajoutez d'abord un prosuit SVP", context,
                        duration: 1,
                        gravity: Toast.CENTER,
                        textColor: Color(0xFF66FCF1));
                  } else {
                    RetrieveUnit();
                  }
                });
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildListViewUnite() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('Paidproduct').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: Hive.box('TotalunitEvening').length,
          itemBuilder: (context, index) {
            final unit = Hive.box('TotalunitEvening').getAt(index) as TotalUnit;
            return Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child: Text(unit.product.toString(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              textAlign: TextAlign.start)),
                      Container(
                          alignment: Alignment.center,
                          width: 40,
                          child: Text(unit.unite.toString(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                Container(
                    height: 2,
                    width: double.maxFinite,
                    color: Color(0xFF15171e)),
              ],
            );
          },
        );
      },
    );
  }
}
