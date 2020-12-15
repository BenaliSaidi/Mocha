import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/productList.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _buyingPrice;
  String _sellingPrice;

  void addNewProduct (NewProduct product){
    final productsBox = Hive.box('product');
    productsBox.add(product);
    print("this is " + product.name );
    print("this is buying price  " + product.buyingPrice.toString() );
    print("this is seling price " + product.sellingPrice.toString() );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomPadding: true,
        //resizeToAvoidBottomInset: false,
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
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 00.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor : Colors.white10,
                      labelText: 'Nom',
                      labelStyle: TextStyle(
                          color: Color(0xFF66FCF1),fontSize: 13
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide : BorderSide(width: 2,color: Color(0xFF66FCF1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    onSaved: (value) => _name = value,
                  ),
                  SizedBox( height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor : Colors.white10,
                      labelText: 'Prix d_achat',
                      labelStyle: TextStyle(
                          color: Color(0xFF66FCF1),fontSize: 13
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide : BorderSide(width: 2,color: Color(0xFF66FCF1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    onSaved: (value) => _buyingPrice = value,
                  ),
                  SizedBox( height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor : Colors.white10,
                      labelText: 'Prix de vente',
                      labelStyle: TextStyle(
                          color: Color(0xFF66FCF1),fontSize: 13
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide : BorderSide(width: 2,color: Color(0xFF66FCF1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    onSaved: (value) => _sellingPrice = value,
                  ),
                  SizedBox( height: 20),
                  RaisedButton(
                    color: Color(0xFF66FCF1) ,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: (){
                      _formKey.currentState.save();
                      final newproduct = NewProduct(_name, int.parse(_sellingPrice) , int.parse(_buyingPrice));
                      addNewProduct(newproduct);
                      _formKey.currentState.reset();
                    },
                    child: Text('Sauvegarder' ,
                        style: TextStyle(fontSize: 20  )),
                  )

                ],
              )

          ),
        ),
      ),
    );
  }
}



