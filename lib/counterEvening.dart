import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mocha/model/histTable.dart';
import 'package:mocha/model/unitproduct.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'model/deletedProduct.dart';
import 'model/order.dart';
import 'model/paidproduct.dart';

Size displaySize(BuildContext context) {
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

List<String> productsnameList = [];
List<int> productsellingpriceList = [];

List<int> productkeyList = [];
List<dynamic> filtreList = [];

List<int> productbenefitsList = [];
List<int> productindexList = [];
List<int> benefitList = [];
List<int> productbuyingpriceList = [];

List<dynamic> allkeysList = [];
List<dynamic> allList = [];
List<String> TableList = [];

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF455A64);
//#455A64
Color buttoncolor = Color(0xFF0a0a0a);
int row;
double font;

var newFormat = DateFormat("yyyy-MM-dd");

void addNewOrder(NewOrder order) {
  final ordersBox = Hive.box('order');
  var lengthBox = Hive.box('order').values;
  if (lengthBox.isEmpty) {
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

List<String> RetListTable() {
  TableList.clear();
  List tableListObj = Hive.box('table').values.toList();
  tableListObj.forEach((element) {
    TableList.add(element.name);
  });

  return TableList;
}

void addToPaidProduct(PaidProduct paidProduct) {
  final PpBox = Hive.box('Paidproduct');
  PpBox.add(paidProduct);
}

void addToHistory(HistTable historytable) {
  Hive.box('history').add(historytable);
}

void addTodelPro(DelProduct delPro) {
  Hive.box('deletedProduct').add(delPro);
}

void addNewUnit(Unit unit) {
  final statBox = Hive.box('unitEvening');
  statBox.add(unit);
}

clearOldUNit() {
  Hive.box('unitEvening').clear();
}

clearOldTotalUNit() {
  Hive.box('TotalunitEvening').clear();
}

clear() {
  Hive.box('order').clear();
  print('deleeeeete');
}

class CounterEvening extends StatefulWidget {
  final String Tablevalue;
  CounterEvening({this.Tablevalue});

  @override
  _CounterEveningState createState() =>
      _CounterEveningState(Tablevalue: Tablevalue);
}

class _CounterEveningState extends State<CounterEvening> {
  String Tablevalue;
  _CounterEveningState({this.Tablevalue});

  int lenghtList;
  String newTable = Hive.box("table").getAt(0).name;

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
        .where((order) => order.tables == Tablevalue)
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

  ValueNotifier<int> sumP = ValueNotifier(0);
  calculatePrice() {
    var pricesList = Hive.box('order')
        .values
        .where((order) => order.tables == Tablevalue)
        .toList();

    prices.clear();
    if (prices.isEmpty) {
      prices.add(0);
    }
    pricesList.forEach((item) => prices.add(item.sellingPrice));
    //print(prices);
    sumP.value = prices.reduce((curr, next) => curr + next);
    //print(sumP);
    return sumP;
  }

  calculateBenefit() {
    var benefitList = Hive.box('order')
        .values
        .where((order) => order.tables == Tablevalue)
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

  String name;

  @override
  Widget build(BuildContext context) {
    clearOldUNit();
    calculatePrice();
    // allList.clear();
    // filtreList.clear();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            // actions: [
            //   Pfadding(
            //     padding: const EdgeInsets.only(right: 20.0),
            //     child: IconButton(
            //       onPressed: () {
            //         setState(() {
            //           allList.clear();
            //           filtreList.clear();
            //         });
            //       },
            //       icon: Icon(Icons.refresh),
            //     ),
            //   )
            // ],
            title: Text(
              'Table ' + Tablevalue.toString(),
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF455A64),
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
                                        color: Color(0xFF455A64),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                child: Text(
                                  'Prix',
                                  style: TextStyle(
                                      fontSize: fontsize(),
                                      color: Color(0xFF455A64),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 30,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color(0x00000000),
                                  ),
                                  onPressed: () {},
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
                          color: Color(0xFF455A64),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: sumP,
                                builder: (context, value, child) {
                                  return Text(
                                      '    Total : ' + value.toString() + ' DA',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                },
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              OutlineButton(
                                splashColor: Color(0xFF45A29E),
                                highlightedBorderColor: Color(0xFF45A29E),
                                child: Text(
                                  "Clôturer",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Map<int, String> nameVal = {};
                                  Map<int, String> pariceVal = {};
                                  final item = Hive.box('order')
                                      .values
                                      .where(
                                          (order) => order.tables == Tablevalue)
                                      .toList();
                                  if (item.length == 0) {
                                    Toast.show(
                                        "veuillez d'abord ajouter des produits",
                                        context,
                                        duration: 1,
                                        gravity: Toast.CENTER,
                                        textColor: Colors.white);
                                  } else {
                                    item.forEach((element) {
                                      int id = item.indexOf(element);
                                      String name = element.name;
                                      int slgPrice = element.sellingPrice;
                                      int benefit = element.benefit;

                                      nameVal[id] = name;
                                      pariceVal[id] = slgPrice.toString();

                                      print(id);

                                      final paidproduct =
                                          PaidProduct(name, slgPrice, benefit);
                                      addToPaidProduct(paidproduct);
                                    });
                                    var totalPrice = calculatePrice();
                                    final DateTime now = DateTime.now();
                                    final DateFormat formatter =
                                        DateFormat('HH:mm:ss');
                                    final String formatted =
                                        formatter.format(now);

                                    final historyproduct = HistTable(
                                        totalPrice,
                                        Tablevalue,
                                        formatted,
                                        pariceVal,
                                        nameVal);
                                    addToHistory(historyproduct);

                                    listToDelete.clear();
                                    item.forEach(
                                        (item) => listToDelete.add(item.key));

                                    listToDelete.forEach((element) {
                                      Hive.box('order').delete(element);
                                    });

                                    setState(() {
                                      calculatePrice();
                                    });
                                    Toast.show(
                                      "Table payée !! ",
                                      context,
                                      duration: 1,
                                      gravity: Toast.CENTER,
                                      textColor: Colors.white,
                                    );
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
                    child: ListView.builder(
                        itemCount: Hive.box('categorie').length,
                        itemBuilder: (context, index) {
                          final cat = Hive.box('categorie').getAt(index);
                          filtreList = Hive.box('product')
                              .values
                              .where((element) =>
                                  element.categorie == cat.categorie.toString())
                              .toList();

                          allList.add(filtreList);

                          return Container(
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    height: 60,
                                    width: double.maxFinite,
                                    color: Color(0xFF15171e),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15, bottom: 15),
                                      child: Center(
                                        child: Text(
                                          cat.categorie
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Colors.grey[300]),
                                        ),
                                      ),
                                    )),
                                Container(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 5),
                                    mainAxisSpacing: 3.0,
                                    crossAxisSpacing: 3.0,
                                    scrollDirection: Axis.vertical,
                                    crossAxisCount: GridViewlayout(),
                                    children: List.generate(
                                        Hive.box('product')
                                            .values
                                            .where((element) =>
                                                element.categorie ==
                                                cat.categorie)
                                            .length, (indexone) {
                                      return Container(
                                        child: RaisedButton(
                                          splashColor: Color(0xFF45A29E),
                                          color: Colors.grey[800],
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            var key = Hive.box('order').values;
                                            if (key.isEmpty) {
                                              print('fiiiiiiiiirst');
                                              final neworder = NewOrder(
                                                  allList[index][indexone].name,
                                                  allList[index][indexone]
                                                      .buyingPrice,
                                                  allList[index][indexone]
                                                      .sellingPrice,
                                                  allList[index][indexone]
                                                      .benefit,
                                                  Tablevalue,
                                                  1);

                                              addNewOrder(neworder);

                                              setState(() {
                                                calculatePrice();
                                              });
                                              Vibration.vibrate(duration: 100);

                                              clearOldUNit();
                                            } else {
                                              key.forEach((item) =>
                                                  allkeysList.add(item.key));
                                              int lastkeyElement =
                                                  allkeysList.last;
                                              int newkeyElement =
                                                  lastkeyElement + 1;

                                              final neworder = NewOrder(
                                                  allList[index][indexone].name,
                                                  allList[index][indexone]
                                                      .buyingPrice,
                                                  allList[index][indexone]
                                                      .sellingPrice,
                                                  allList[index][indexone]
                                                      .benefit,
                                                  Tablevalue,
                                                  newkeyElement);

                                              addNewOrder(neworder);

                                              setState(() {
                                                calculatePrice();
                                              });
                                              Vibration.vibrate(duration: 100);

                                              clearOldUNit();
                                            }
                                            lenghtList = filtreList.length;
                                          },
                                          child: Text(
                                            '${allList[index][indexone].name}'
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Recursive',
                                              fontSize: fontsize(),
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
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
                                          color: Color(0xFF455A64),
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 100,
                                  child: Text(
                                    'Unités',
                                    style: TextStyle(
                                        fontSize: fontsize(),
                                        color: Color(0xFF455A64),
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
                                  fontSize: 25, color: Colors.white70),
                            ),
                            onPressed: () {
                              setState(() {
                                if (Hive.box('unitEvening').length == 0) {
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
              .where((order) => order.tables == Tablevalue)
              .length,
          itemBuilder: (context, index) {
            final filtre = Hive.box('order')
                .values
                .where((order) => order.tables == Tablevalue)
                .toList();

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
                      Container(
                        alignment: Alignment.center,
                        width: 90,
                        child: Text('${productname[index]}'.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
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
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
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
                            color: Color(0xFF455A64),
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
                            DateTime now = DateTime.now();
                            DateFormat formatter = DateFormat('HH:mm:ss');
                            String formatted = formatter.format(now);

                            Map<int, String> selPrice = {};
                            Map<int, String> selname = {};

                            selPrice[0] = sp.toString();
                            selname[0] = name;

                            var historyproduct = HistTable(
                                sp, Tablevalue, formatted, selPrice, selname);
                            addToHistory(historyproduct);
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
                            Icons.edit,
                            color: Colors.teal[700],
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                            content: Container(
                                              height: 200,
                                              child: SingleChildScrollView(
                                                child: Form(
                                                    //  key: _formKey,
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                          'Veuillez Inserer la table SVP'),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey[600]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: DropdownButton(
                                                          hint: Text('Table'),
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              newTable = newValue
                                                                  .toString();
                                                            });
                                                          },
                                                          value: newTable,
                                                          isExpanded: true,
                                                          items: RetListTable()
                                                              .map((e) {
                                                            return DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e),
                                                            );
                                                          }).toList(),
                                                        )),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    RaisedButton(
                                                      color: buttoncolor,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 15, 10, 15),
                                                      onPressed: () {
                                                        var name =
                                                            Hive.box('order')
                                                                .get(productkey[
                                                                    index])
                                                                .name;
                                                        var sp =
                                                            Hive.box('order')
                                                                .get(productkey[
                                                                    index])
                                                                .sellingPrice;
                                                        var bp =
                                                            Hive.box('order')
                                                                .get(productkey[
                                                                    index])
                                                                .benefit;

                                                        var bypr =
                                                            Hive.box('order')
                                                                .get(productkey[
                                                                    index])
                                                                .sellingPrice;
                                                        var key =
                                                            Hive.box('order')
                                                                .values;
                                                        Hive.box('order')
                                                            .delete(productkey[
                                                                index]);
                                                        if (key.isEmpty) {
                                                          print(
                                                              'fiiiiiiiiirst');
                                                          final neworder =
                                                              NewOrder(
                                                                  name,
                                                                  bypr,
                                                                  sp,
                                                                  bp,
                                                                  newTable,
                                                                  1);

                                                          addNewOrder(neworder);

                                                          setState(() {
                                                            calculatePrice();
                                                          });
                                                          Vibration.vibrate(
                                                              duration: 100);

                                                          clearOldUNit();
                                                        } else {
                                                          key.forEach((item) =>
                                                              allkeysList.add(
                                                                  item.key));
                                                          int lastkeyElement =
                                                              allkeysList.last;
                                                          int newkeyElement =
                                                              lastkeyElement +
                                                                  1;

                                                          final neworder =
                                                              NewOrder(
                                                                  name,
                                                                  bypr,
                                                                  sp,
                                                                  bp,
                                                                  newTable,
                                                                  newkeyElement);

                                                          addNewOrder(neworder);

                                                          Vibration.vibrate(
                                                              duration: 100);
                                                          lenghtList =
                                                              filtreList.length;
                                                          setState(() {
                                                            calculatePrice();
                                                          });
                                                          clearOldUNit();
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('transférez',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  backgroundcolor)),
                                                    )
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ));
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
                            var name =
                                Hive.box('order').get(productkey[index]).name;
                            var sp = Hive.box('order')
                                .get(productkey[index])
                                .sellingPrice;

                            DateTime now = DateTime.now();
                            DateFormat formatter = DateFormat('HH:mm:ss');
                            String formatted = formatter.format(now);

                            var del_Prod =
                                DelProduct(name, sp, Tablevalue, formatted);
                            addTodelPro(del_Prod);
                            Hive.box('order').delete(productkey[index]);

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
          itemCount: Hive.box('unitEvening').length,
          itemBuilder: (context, index) {
            final unit = Hive.box('unitEvening').getAt(index) as Unit;
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
