import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mocha/model/unitproduct.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'model/order.dart';
import 'model/paidproduct.dart';

Size displaySize(BuildContext context) {
  print('Size = ' + MediaQuery.of(context).size.toString());
  print(MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

List<dynamic> listToDelete = [];
List<dynamic> listOfTable = [];
List<int> prices = [];
List<dynamic> allorder = [];
List<dynamic> allkeys = [];
List<String> productname = [];
List<int> productsellingprice = [];
List<int> productbenefits = [];
List<int> productindex = [];
List<int> benefit = [];
List<int> productkey = [];

List<String> unite = [];
List<dynamic> filtre = [];

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);
int row;
double font;

var newFormat = DateFormat("yyyy-MM-dd");

void addNewOrder(NewOrder order) {
  final ordersBox = Hive.box('order');
  var lengthBox = Hive.box('order').values;
  if (Hive.box('order').values.isEmpty) {
    ordersBox.put(1, order);
    print('the box is empty');
  } else {
    lengthBox.forEach((item) => allorder.add(item.key));
    int lastElement = allorder.last;
    int newElement = lastElement + 1;
    ordersBox.put(newElement, order);
    allorder.clear();
  }
}

void addToPaidProduct(PaidProduct paidProduct) {
  // ignore: non_constant_identifier_names
  Hive.openBox('Paidproduct');
  final PpBox = Hive.box('Paidproduct');
  PpBox.add(paidProduct);
}

void addNewUnit(Unit unit) {
  final statBox = Hive.box('unitMorning');
  statBox.add(unit);
}

clearOldUNit() {
  Hive.box('unitMorning').clear();
}

clearOldTotalUNit() {
  Hive.box('TotalunitMorning').clear();
}

class CounterMorning extends StatefulWidget {
  String value;
  CounterMorning({this.value});

  @override
  _CounterMorningState createState() => _CounterMorningState(value: value);
}

class _CounterMorningState extends State<CounterMorning> {
  String value;
  _CounterMorningState({this.value});

  int GridViewlayout() {
    if (displaySize(context).width < 400) {
      row = 5;
    } else if (400 < displaySize(context).width &&
        800 > displaySize(context).width) {
      row = 7;
    } else {
      row = 10;
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

  RetrieveUnit() {
    var map = Map();
    unite.clear();
    var productList = Hive.box('order')
        .values
        .where((order) => order.tables == value)
        .toList();
    productList.forEach((item) => unite.add(item.name));
    unite.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    //print(map);
    map.forEach((k, v) {
      final listeUnit = Unit(k, v);
      addNewUnit(listeUnit);
    });
  }

  calculatePrice() {
    var pricesList = Hive.box('order')
        .values
        .where((order) => order.tables == value)
        .toList();

    prices.clear();
    if (prices.isEmpty) {
      prices.add(0);
    }
    pricesList.forEach((item) => prices.add(item.sellingPrice));
    //print(prices);
    int sumP = prices.reduce((curr, next) => curr + next);
    //print(sumP);
    return sumP;
  }

  calculateBenefit() {
    var benefitList = Hive.box('order')
        .values
        .where((order) => order.tables == value)
        .toList();
    benefit.clear();
    if (benefit.isEmpty) {
      benefit.add(0);
    }
    benefitList.forEach((item) => benefit.add(item.benefit));
    //print(benefit);
    int sumB = benefit.reduce((curr, next) => curr + next);
    //print(sumB);
    return sumB;
  }

  final _formKey = GlobalKey<FormState>();
  String name;

  @override
  Widget build(BuildContext context) {
    clearOldUNit();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Table ' + value.toString(),
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.teal,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Icon(Icons.emoji_food_beverage_outlined,
                        color: Colors.white)),
                Tab(icon: Icon(Icons.list_alt, color: Colors.white)),
                Tab(icon: Icon(Icons.calculate, color: Colors.white)),
              ],
            ),
          ),
          body: Container(
            color: backgroundcolor,
            child: TabBarView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          tileColor: Color(0xFF15171e),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                child: Text('Article',
                                    style: TextStyle(
                                        fontSize: fontsize(),
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                child: Text(
                                  'Prix',
                                  style: TextStyle(
                                      fontSize: fontsize(),
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete,
                                      color: Color(0x00000000)),
                                ),
                              ),
                              Container(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete,
                                      color: Color(0x00000000)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _buildListView()),
                      Container(
                          color: Colors.teal,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '    Total : ' +
                                      calculatePrice().toString() +
                                      ' DA',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 50,
                              ),
                              OutlineButton(
                                splashColor: Color(0xFF45A29E),
                                highlightedBorderColor: Color(0xFF45A29E),
                                child: Text(
                                  "clôturer",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  final item = Hive.box('order')
                                      .values
                                      .where((order) => order.tables == value)
                                      .toList();
                                  if (item.length == 0) {
                                    Toast.show(
                                        "veuillez d'abord ajouter des produits",
                                        context,
                                        duration: 1,
                                        gravity: Toast.CENTER,
                                        textColor: Color(0xFF66FCF1));
                                  } else {
                                    item.forEach((element) {
                                      String name = element.name;
                                      int slgPrice = element.sellingPrice;
                                      int benefit = element.benefit;

                                      final paidproduct =
                                          PaidProduct(name, slgPrice, benefit);
                                      addToPaidProduct(paidproduct);

                                      var a =
                                          Hive.box('Paidproduct').values.length;
                                      print('a = $a');
                                    });

                                    listToDelete.clear();
                                    item.forEach(
                                        (item) => listToDelete.add(item.key));
                                    print('list to delete is $listToDelete');
                                    listToDelete.forEach((element) {
                                      Hive.box('order').delete(element);
                                    });

                                    setState(() {
                                      calculatePrice();
                                    });
                                    Toast.show(
                                        "Bravo vous avez clôturé la journée",
                                        context,
                                        duration: 1,
                                        gravity: Toast.CENTER,
                                        textColor: Color(0xFF66FCF1));
                                    clearOldTotalUNit();
                                  }
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  child: GridView.count(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: GridViewlayout(),
                    children:
                        List.generate(Hive.box('product').length, (index) {
                      final products = Hive.box('product').getAt(index);

                      return RaisedButton(
                        splashColor: Color(0xFF45A29E),
                        color: Color(0xFF15171e),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          var key = Hive.box('order').values;
                          if (Hive.box('order').values.isEmpty) {
                            final neworder = NewOrder(
                                products.name,
                                products.buyingPrice,
                                products.sellingPrice,
                                products.benefit,
                                value,
                                1);

                            addNewOrder(neworder);
                            print(products.name + '    ' + value);

                            setState(() {
                              calculatePrice();
                            });
                            Vibration.vibrate(duration: 100);
                            clearOldUNit();
                          } else {
                            key.forEach((item) => allkeys.add(item.key));
                            int lastkeyElement = allkeys.last;
                            int newkeyElement = lastkeyElement + 1;
                            final neworder = NewOrder(
                                products.name,
                                products.buyingPrice,
                                products.sellingPrice,
                                products.benefit,
                                value,
                                newkeyElement);

                            addNewOrder(neworder);
                            print(products.name + '    ' + value);

                            setState(() {
                              calculatePrice();
                            });
                            Vibration.vibrate(duration: 100);
                            clearOldUNit();
                          }
                        },
                        child: Text(
                          products.name,
                          style: TextStyle(
                              fontSize: fontsize(), color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          child: ListTile(
                            tileColor: Color(0xFF15171e),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 130,
                                  child: Text('Article',
                                      style: TextStyle(
                                          fontSize: fontsize(),
                                          color: Color(0xFF45A29E),
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 60,
                                  child: Text(
                                    'Unités',
                                    style: TextStyle(
                                        fontSize: fontsize(),
                                        color: Color(0xFF45A29E),
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
                            color: Color(0xFF0B0C10),
                            child: Text(
                              'Actualisez',
                              style: TextStyle(
                                  fontSize: 25, color: Color(0xFF45A29E)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (Hive.box('unitMorning').length == 0) {
                                  RetrieveUnit();
                                } else {
                                  Toast.show(
                                      "Ajoutez d'abord un prosuit SVP", context,
                                      duration: 3,
                                      gravity: Toast.CENTER,
                                      textColor: Color(0xFF66FCF1));
                                }
                              });
                            },
                          ),
                        )
                      ]),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('order').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: Hive.box('order')
              .values
              .where((order) => order.tables == value)
              .length,
          itemBuilder: (context, index) {
            final filtre = Hive.box('order')
                .values
                .where((order) => order.tables == value)
                .toList();
            //***** */
            productname.clear();
            productsellingprice.clear();
            productbenefits.clear();
            productkey.clear();
            filtre.forEach((item) {
              productname.add(item.name);
              productsellingprice.add(item.sellingPrice);
              productbenefits.add(item.benefit);
              productkey.add(item.key);
            });

            return ListTile(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: 30,
                      //   child: Text('${productkey[index]}'.toString(),
                      //       style: TextStyle(fontSize: 15, color: Colors.black,),
                      //       textAlign: TextAlign.center),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        width: 90,
                        child: Text('${productname[index]}'.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Text('${productsellingprice[index]}'.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.attach_money_rounded,
                            color: Color(0xFF45A29E),
                          ),
                          onPressed: () {
                            var name =
                                Hive.box('order').get(productkey[index]).name;
                            var sp = Hive.box('order')
                                .get(productkey[index])
                                .sellingPrice;
                            var bp = Hive.box('order')
                                .get(productkey[index])
                                .benefit;
                            print('nom $name');
                            print('nom $sp');
                            print('nom $bp');
                            Hive.box('order').delete(productkey[index]);
                            final paidproduct = PaidProduct(name, sp, bp);
                            addToPaidProduct(paidproduct);
                            Toast.show("Paid", context,
                                duration: 1,
                                gravity: Toast.BOTTOM,
                                textColor: Color(0xFF66FCF1));
                            setState(() {
                              calculatePrice();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xFF9a4c40),
                          ),
                          onPressed: () {
                            print(productkey[index]);
                            Hive.box('order').delete(productkey[index]);
                            // productname.removeAt(index);
                            Toast.show("Produit supprimé avec succès", context,
                                duration: 1,
                                gravity: Toast.BOTTOM,
                                textColor: Color(0xFF66FCF1));
                            setState(() {
                              calculatePrice();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 2,
                      width: double.maxFinite,
                      color: Color(0xFF15171e))
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListViewUnite() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('order').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: Hive.box('unitMorning').length,
          itemBuilder: (context, index) {
            final unit = Hive.box('unitMorning').getAt(index) as Unit;
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
            // Container(height: 5,color: Colors.red),
          },
        );
      },
    );
  }
}
