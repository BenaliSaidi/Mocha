import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mocha/model/productList.dart';
import 'package:mocha/model/statList.dart';
import 'package:mocha/model/unitproduct.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';




List<int> prices = [];
List<int> benefit = [];
List<String> unite = [];


var newFormat = DateFormat("yyyy-MM-dd");


timeNow(){
  return newFormat.format(DateTime.now());
}

void addNewProductToCounter (NewProduct product) {
  final productsBox = Hive.box('counterEvening');
  productsBox.add(product);
}

calculatePrice (){
  var pricesList = Hive.box('counterEvening').values.toList() ;
  prices.clear();
  if (prices.isEmpty){prices.add(0);}
  pricesList.forEach((item) => prices.add(item.sellingPrice));
  print(prices);
  int sumP = prices.reduce((curr, next) => curr + next);
  print(sumP);
  return sumP ;
}
calculateBenefit (){
  var benefitList = Hive.box('counterEvening').values.toList() ;
  benefit.clear();
  if (benefit.isEmpty){benefit.add(0);}
  benefitList.forEach((item) => benefit.add(item.benefit));
  print(benefit);
  int sumB = benefit.reduce((curr, next) => curr + next);
  print(sumB);
  return sumB ;
}

void addNewEveningStat (NewList stat){
  final statBox = Hive.box('statEvening');
  statBox.add(stat);
}

void addNewUnit (Unit unit){
  final statBox = Hive.box('unitEvening');
  statBox.add(unit);
}



RetrieveUnit(){
    var map = Map();
    unite.clear();
    var productList = Hive.box('counterEvening').values.toList() ;
    productList.forEach((item) => unite.add(item.name));
    unite.forEach((element) {
      if(!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] +=1;
      }
    });
    print(map);
    map.forEach((k , v  ) {
      final listeUnit = Unit(k, v );
      addNewUnit(listeUnit);
    });


}

clearOldUNit(){
  Hive.box('unitEvening').clear();
}

class CounterEvening extends StatefulWidget {

  @override
  _CounterEveningState createState() => _CounterEveningState();
}
class _CounterEveningState extends State<CounterEvening> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Soir',
              style: TextStyle(
                  fontSize: 30 , color: Color(0xFF66FCF1)
              ),),
            centerTitle: true,
            backgroundColor: Color(0xFF0B0C10),
            bottom: TabBar(
              indicatorColor: Color(0xFF66FCF1) ,
              tabs: [
                Tab(icon: Icon(Icons.emoji_food_beverage_outlined ,color: Color(0xFF66FCF1) )),
                Tab(icon: Icon(Icons.list_alt , color: Color(0xFF66FCF1))),
                Tab(icon: Icon(Icons.calculate , color: Color(0xFF66FCF1))),
              ],
            ),
          ),
          body: Container(
            color: Color(0xFF1F2833),
            child: TabBarView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListTile(
                          tileColor: Color(0xFF15171e),
                          title:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center ,
                                width : 90,
                                child: Text('Article', style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold )),
                              ),
                              Container(
                                alignment: Alignment.center ,
                                width : 70,
                                child: Text('Prix' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.delete,color: Color(0x00000000)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _buildListView()),
                      Container(
                          color: Color(0xFF15171e),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('    Total : ' + calculatePrice().toString() + ' DA',
                                  style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold)),
                              SizedBox(width: 50,),
                              OutlineButton(
                                splashColor:Color(0xFF45A29E),
                                highlightedBorderColor: Color(0xFF45A29E),
                                child: Text("clôturer" , style: TextStyle(fontSize: 15, color: Color(0xFF45A29E) ),),
                                borderSide: BorderSide(
                                  color: Color(0xFF45A29E),
                                ),
                                onPressed: () {
                                  if(Hive.box('counterEvening').length == 0){
                                    Toast.show("veuillez d'abord ajouter des produits", context,
                                        duration: 3,
                                        gravity:  Toast.CENTER,
                                        textColor: Color(0xFF66FCF1));
                                  }
                                  else{
                                    final listeStat = NewList(calculatePrice(),calculateBenefit(),timeNow());
                                    addNewEveningStat(listeStat);
                                    Hive.box('counterEvening'
                                        ).clear();

                                    setState(() {
                                      calculatePrice();
                                    });
                                    Toast.show("Bravo vous avez clôturé la journée", context,
                                        duration: 3,
                                        gravity:  Toast.CENTER,
                                        textColor: Color(0xFF66FCF1));
                                  }
                                },
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Container(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 5 ,
                    children: List.generate(Hive.box('product').length,(index){
                      final products = Hive.box('product').getAt(index) as NewProduct;
                      return RaisedButton(
                        splashColor:Color(0xFF45A29E),
                        color: Color(0xFF15171e),
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          final newproduct =
                          NewProduct(products.name, products.buyingPrice , products.sellingPrice , products.benefit);
                          addNewProductToCounter(newproduct);
                          print (products.name);
                          setState(() {
                            calculatePrice();
                          });
                          Vibration.vibrate(duration: 100);
                          clearOldUNit();
                        },
                        child:
                        Text(products.name,
                          style: TextStyle(fontSize:14 , color: Colors.white70),
                          textAlign:TextAlign.center,
                        ),
                      );
                    }
                    ),
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
                            title:Row(

                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft ,
                                  width : 130,
                                  child: Text('Article', style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight ,
                                  width :60,
                                  child: Text('Unités' , style: TextStyle(fontSize: 18 ,color:Color(0xFF45A29E),fontWeight: FontWeight.bold ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: _buildListViewUnite()),
                        ButtonTheme(
                          splashColor: Color(0xFF45A29E),
                          minWidth:double.infinity,
                          height: 50,
                          child: RaisedButton(
                            color: Color(0xFF0B0C10),
                            child: Text('Actualisez' ,style: TextStyle(fontSize: 25 , color:Color(0xFF45A29E) ),),
                            onPressed:(){
                              setState(() {
                                if( Hive.box('unitEvening').length == 0){ RetrieveUnit();}
                                else {Toast.show("Ajoutez d'abord un prosuit SVP", context,
                                    duration: 3,
                                    gravity:  Toast.CENTER,
                                    textColor: Color(0xFF66FCF1));}
                              });

                            },),
                        )

                      ]

                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildListView(){
    return ValueListenableBuilder(
      valueListenable: Hive.box('counterEvening').listenable(),
      builder: (context, box, widget) {
        return
          ListView.builder(
            itemCount: Hive.box('counterEvening').length,
            itemBuilder: (context, index) {
              final products = Hive.box('counterEvening').getAt(index) as NewProduct;
              return
                ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center ,
                        width: 90,
                        child:Text(products.name,style: TextStyle(fontSize:15 , color: Colors.grey),textAlign:TextAlign.center ),
                      ),
                      Container(
                        alignment: Alignment.center ,
                        width: 70,
                        child:Text(products.sellingPrice.toString() ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete,color: Color(0xFF45A29E) ,),
                          onPressed: () {
                            Hive.box('counterEvening').deleteAt(index);
                            Toast.show("Produit supprimé avec succès", context,
                                duration: 2,
                                gravity:  Toast.BOTTOM,
                                textColor: Color(0xFF66FCF1));
                            setState(() {
                              calculatePrice();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                );
            },
          );

      },
    );

  }
  Widget _buildListViewUnite(){
    return ValueListenableBuilder(
      valueListenable: Hive.box('counterEvening').listenable(),
      builder: (context, box, widget) {
        return
          ListView.builder(
            itemCount: Hive.box('unitEvening').length,
            itemBuilder: (context, index) {
              final unit = Hive.box('unitEvening').getAt(index) as Unit;
              return
                Column(
                  children: [
                    ListTile(
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft ,
                              width:150,
                              child:
                              Text(unit.product.toString(), style: TextStyle(fontSize: 17, color: Colors.white70),textAlign:TextAlign.start)),
                          Container(
                              alignment: Alignment.center ,
                              width: 40,
                              child:
                              Text(unit.unite.toString(), style: TextStyle(fontSize: 17,color: Colors.white70),textAlign:TextAlign.center)),
                        ],
                      ),
                    ),
                    Container(height: 2,width: double.maxFinite ,color:Color(0xFF15171e)),
                  ],
                );
              // Container(height: 5,color: Colors.red),
            },
          );

      },
    );

  }


}
