import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mocha/CounterMenu.dart';
import 'package:mocha/model/productList.dart';
import 'package:mocha/model/statList.dart';
import 'package:toast/toast.dart';

List<int> prices = [];
List<int> benefit = [];
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
  var sumP = prices.reduce((curr, next) => curr + next);
  print(sumP);
  return sumP ;
}
calculateBenefit (){
  var benefitList = Hive.box('counterEvening').values.toList() ;
  benefit.clear();
  if (benefit.isEmpty){benefit.add(0);}
  benefitList.forEach((item) => benefit.add(item.benefit));
  print(benefit);
  var sumB = benefit.reduce((curr, next) => curr + next);
  print(sumB);
  return sumB ;
}
void addNewMorningStat (NewList stat){
  final statBox = Hive.box('statEvening');
  statBox.add(stat);
}

class CounterEvening extends StatefulWidget {
  @override
  _CounterEveningState createState() => _CounterEveningState();
}
class _CounterEveningState extends State<CounterEvening> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                                    addNewMorningStat(listeStat);
                                    Hive.box('counterEvening').clear();
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
                      return Container(
                        child: GestureDetector(
                          onTap: (){
                            final newproduct =
                            NewProduct(products.name, products.buyingPrice , products.sellingPrice , products.benefit);
                            addNewProductToCounter(newproduct);
                            print (products.name);
                            setState(() {
                              calculatePrice();
                            });
                          },
                          child:
                          Card(
                              color: Color(0xFF646668),
                              child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child : Text(products.name,
                                      style: TextStyle(fontSize:14 , color: Colors.black),
                                      textAlign:TextAlign.center,
                                    ),
                                  )

                              )

                          ),
                        ),
                      );
                    }
                    ),
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
}
