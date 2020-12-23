import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocha/addnewproduct.dart';
import 'package:mocha/model/productList.dart';
import 'package:toast/toast.dart';

// ignore: camel_case_types
class productList extends StatelessWidget {
   productList({
    Key key,
  }) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2833),
      appBar: AppBar(
      title: Text('Mocha', style: TextStyle(fontSize: 30 , color: Color(0xFF66FCF1)),),
      centerTitle: true,
      backgroundColor: Color(0xFF0B0C10),
      ),
      body:
      Column(
          children: [
            ListTile(
              tileColor: Color(0xFF15171e),
              // trailing: IconButton(
              //   onPressed: (){},
              //   icon: Icon(Icons.delete,color: Color(0x00000000)),
              // ),
              title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center ,
                    width : 70,
                    child: Text('Article', style: TextStyle(fontSize: 15 ,color:Color(0xFF45A29E) )),
                  ),
                  Container(
                    alignment: Alignment.center ,
                    width : 50,
                    child: Text('Prix A' , style: TextStyle(fontSize: 15 ,color:Color(0xFF45A29E)),),
                  ),
                  Container(
                    alignment: Alignment.center ,
                    width : 50,
                    child: Text('Prix V' , style: TextStyle(fontSize: 15 ,color:Color(0xFF45A29E)),),
                  ),
                  Container(
                    alignment: Alignment.center ,
                    width : 50,
                    child: Text('Gain' , style: TextStyle(fontSize: 15,color:Color(0xFF45A29E)),),
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
          ],
        ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF45A29E) ,
          child: Text('+' , style: TextStyle(fontSize: 30),),
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          }
      ),
      );
  }
  // ignore: missing_return
  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('product').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: Hive.box('product').length,
          itemBuilder: (context, index) {
            final products = Hive.box('product').getAt(index) as NewProduct;
            return
                ListTile(

                  title:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center ,
                        width: 70,
                        child:Text(products.name,style: TextStyle(fontSize:16 , color: Colors.grey),textAlign:TextAlign.center ),
                      ),
                      Container(
                        alignment: Alignment.center ,
                        width: 50,
                        child:Text(products.buyingPrice.toString() ,style: TextStyle(fontSize:15 , color: Colors.grey),textAlign:TextAlign.right,),
                      ),
                      Container(
                        alignment: Alignment.center ,
                        width: 50,
                        child:Text(products.sellingPrice.toString() ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                      ),
                      Container(
                        alignment: Alignment.center ,
                        width: 50,
                        child:Text(products.benefit.toString() ,style: TextStyle(fontSize: 15 , color: Colors.grey),textAlign:TextAlign.left),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete,color: Color(0xFF45A29E) ,),
                          onPressed: () {
                            Hive.box('product').deleteAt(index);
                            Toast.show("Produit supprimé avec succès", context,
                                duration: 2,
                                gravity:  Toast.BOTTOM,
                                textColor: Color(0xFF66FCF1));;
                          },
                        ),
                      )
                      // Text('')
                    ],
                  ),
                );
          },
        );
      },
    );
  }
}
