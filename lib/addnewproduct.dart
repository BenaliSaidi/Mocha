import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mocha/model/addCategorie.dart';
import 'package:mocha/model/productList.dart';
import 'package:toast/toast.dart';

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);
var testou;

final List<String> categorieList = [];

List<String> RetList() {
  categorieList.clear();
  List categorieListObj = Hive.box('categorie').values.toList();
  categorieListObj.forEach((element) {
    categorieList.add(element.categorie);
  });

  return categorieList;
}

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _buyingPrice;
  String _sellingPrice;

  String valueChoose;
  final items = Hive.box('categorie').values.toList();

  void addNewProduct(NewProduct product) {
    final productsBox = Hive.box('product');
    productsBox.add(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Mocha',
          style: TextStyle(fontSize: 30, color: backgroundcolor),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF455A64),
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
                      color: buttoncolor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Nom',
                      labelStyle: TextStyle(color: buttoncolor, fontSize: 13),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 2, color: buttoncolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'SVP entrez un nom valide';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      color: buttoncolor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Prix d\'achat ',
                      labelStyle: TextStyle(color: buttoncolor, fontSize: 13),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 2, color: buttoncolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'SVP entrez un prix de d\'achat valide';
                      }
                      return null;
                    },
                    onSaved: (value) => _buyingPrice = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      color: buttoncolor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      labelText: 'Prix de vente',
                      labelStyle: TextStyle(color: buttoncolor, fontSize: 13),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 2, color: buttoncolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'SVP entrez un prix de vente valide';
                      }
                      return null;
                    },
                    onSaved: (value) => _sellingPrice = value,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[600]),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton(
                      value: valueChoose,
                      isExpanded: true,
                      items: RetList().map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        this.valueChoose = value;
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: buttoncolor,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        final _benefit =
                            int.parse(_sellingPrice) - int.parse(_buyingPrice);
                        print(_benefit);
                        final newproduct = NewProduct(
                            _name,
                            int.parse(_buyingPrice),
                            int.parse(_sellingPrice),
                            _benefit,
                            valueChoose);
                        addNewProduct(newproduct);
                        _formKey.currentState.reset();
                        Toast.show("Produit sauvegardé avec succès", context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            textColor: Colors.white);
                      }
                    },
                    child: Text('Sauvegarder',
                        style: TextStyle(fontSize: 20, color: backgroundcolor)),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
