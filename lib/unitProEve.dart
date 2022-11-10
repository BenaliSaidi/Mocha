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
List<dynamic> tprices = [];

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

void addNewUnit(TotalUnit totalunit) {
  final statBox = Hive.box('TotalunitEvening');
  statBox.add(totalunit);
}

int calculateUnitPrice() {
  var pricesList = Hive.box('Paidproduct').values.toList();

  tprices.clear();
  if (tprices.isEmpty) {
    tprices.add(0);
  }
  pricesList.forEach((item) => tprices.add(item.sellingPrice));
  //print(prices);
  int sumP = tprices.reduce((curr, next) => curr + next);
  //print(sumP);
  return sumP;
}

RetrieveUnit() {
  var bigmap = Map();
  unites.clear();
  var totalproductList = Hive.box('Paidproduct').values.toList();
  totalproductList.forEach((i) => unites.add(i.name));
  unites.forEach((element) {
    if (!bigmap.containsKey(element)) {
      bigmap[element] = 1;
    } else {
      bigmap[element] += 1;
    }
  });
  //print(map);
  bigmap.forEach((k, v) {
    final listeTotalUnit = TotalUnit(k, v);
    addNewUnit(listeTotalUnit);
  });
}

class UnitProEve extends StatefulWidget {
  const UnitProEve({Key key}) : super(key: key);

  @override
  _UnitProEveState createState() => _UnitProEveState();
}

class _UnitProEveState extends State<UnitProEve> {
  @override
  Widget build(BuildContext context) {
    RetrieveUnit();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniT SoiR',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF455A64),
      ),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: 50,
            child: ListTile(
              tileColor: Color(0xFF648391),
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
              color: Color(0xFF455A64),
              child: Text(
                'Actualiser',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              onPressed: () {
                if (Hive.box('Paidproduct').length == 0) {
                  Toast.show("Ajoutez d'abord un prosuit SVP", context,
                      duration: 2,
                      gravity: Toast.CENTER,
                      textColor: Colors.white);
                } else {
                  //RetrieveUnit();
                  Toast.show(calculateUnitPrice().toString() + ' DA ', context,
                      duration: 1,
                      gravity: Toast.BOTTOM,
                      textColor: Colors.white);
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildListViewUnite() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('TotalunitEvening').listenable(),
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
