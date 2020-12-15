import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocha/addnewproduct.dart';
import 'package:mocha/model/productList.dart';

// ignore: camel_case_types
class productList extends StatelessWidget {
  const productList({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2833),
      appBar: AppBar(
      title: Text(
      'Mocha',
      style: TextStyle(
      fontSize: 30 , color: Color(0xFF66FCF1)
      ),),
      centerTitle: true,
      backgroundColor: Color(0xFF0B0C10),
      ),
      body: Column(
          children: [
            Expanded(child: _buildListView()),
          ],
        ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF45A29E) ,
          child: Text('+' , style: TextStyle(fontSize: 25),),
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
            final contact = Hive.box('product').getAt(index) as NewProduct;
            return Column(
              children: [
                ListTile(
                  title: Text(contact.name,style: TextStyle(fontSize: 20 , color: Colors.grey),),
                  subtitle: Text(contact.sellingPrice.toString() ,style: TextStyle(fontSize: 20 , color: Colors.grey)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
