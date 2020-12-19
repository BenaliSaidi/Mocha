import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocha/model/productList.dart';


void addNewProductToCounter (NewProduct product) {
  final productsBox = Hive.box('counterMorning');
  productsBox.add(product);
}

class CounterMorning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mocha',
            style: TextStyle(
                fontSize: 30 , color: Color(0xFF66FCF1)
            ),),
          centerTitle: true,
          backgroundColor: Color(0xFF0B0C10),
          bottom: TabBar(
            indicatorColor: Color(0xFF66FCF1) ,
            labelColor: Colors.red ,
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
                  ListTile(
            tileColor: Color(0xFF15171e),
          title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center ,
              width : 90,
              child: Text('Article', style: TextStyle(fontSize: 14 ,color:Color(0xFF45A29E) )),
            ),
            Container(
              alignment: Alignment.center ,
              width : 70,
              child: Text('Prix V' , style: TextStyle(fontSize: 14 ,color:Color(0xFF45A29E)),),
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
                  Expanded(child: _buildListView()),
                  Container(
                    color: Colors.blueGrey,
                    height: 60,
                    child: Row(
                      children: [
                        Container(

                        )
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
                        },
                          child:
                              Card(
                                color: Color(0xFF646668),
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child : Text(products.name,
                                        style: TextStyle(fontSize:15 , color: Color(0xFF45A29E)),
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
        valueListenable: Hive.box('counterMorning').listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
            itemCount: Hive.box('counterMorning').length,
            itemBuilder: (context, index) {
              final products = Hive.box('counterMorning').getAt(index) as NewProduct;
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
                            Hive.box('counterMorning').deleteAt(index);
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
