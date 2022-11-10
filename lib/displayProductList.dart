import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocha/addnewproduct.dart';
import 'package:mocha/model/productList.dart';
import 'package:mocha/model/addCategorie.dart';
import 'package:toast/toast.dart';

Color backgroundcolor = Color(0xFFececec);
Color appbarcolor = Color(0xFF0a0a0a);
Color buttoncolor = Color(0xFF0a0a0a);

final List<String> categorieListup = [];

List<String> RetListforupdate() {
  categorieListup.clear();
  List categorieListObj = Hive.box('categorie').values.toList();
  categorieListObj.forEach((element) {
    categorieListup.add(element.categorie);
  });

  return categorieListup;
}

void addNewCategorie(Categorie categorie) {
  final CategorieBox = Hive.box('categorie');
  CategorieBox.add(categorie);
}

void updateCategorie(Categorie categorie, int index) {
  final CategorieBox = Hive.box('categorie');
  CategorieBox.putAt(index, categorie);
}

void addNewProduct(NewProduct product) {
  final productsBox = Hive.box('product');
  productsBox.add(product);
}

void updateProduct(int index, NewProduct product) {
  final productsBox = Hive.box('product');
  productsBox.putAt(index, product);
}

// ignore: camel_case_types
class productList extends StatefulWidget {
  productList({
    Key key,
  }) : super(key: key);

  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList> {
  final _formKey = GlobalKey<FormState>();
  String categorieName;
  String _nameup;
  String _buyingPriceup;
  String _sellingPriceup;

  String valueChoose;
  String val;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          title: Text(
            'Mocha',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF455A64),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        //fontSize: 20,
                                        color: buttoncolor,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white10,
                                        labelText: 'Catégorie',
                                        labelStyle: TextStyle(
                                            color: buttoncolor, fontSize: 13),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                              width: 2, color: buttoncolor),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onSaved: (value) => categorieName = value,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'SVP entrez un nom valide';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(buttoncolor)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();

                                            final newcategorie =
                                                Categorie(categorieName);
                                            addNewCategorie(newcategorie);
                                            _formKey.currentState.reset();
                                            Toast.show(
                                                "categorie sauvegardé avec succès",
                                                context,
                                                duration: 1,
                                                gravity: Toast.BOTTOM,
                                                textColor: Color(0xFF66FCF1));
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, bottom: 13),
                                            child: Text(
                                              'Ajouter Une Catégorie',
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 1),
                child: Icon(
                  Icons.add_box,
                  color: backgroundcolor,
                  size: 30,
                ),
              ),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  icon: Icon(Icons.emoji_food_beverage_outlined,
                      color: Colors.white)),
              Tab(icon: Icon(Icons.list_alt, color: Colors.white)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                ListTile(
                  tileColor: Color(0xFF15171e),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 70,
                        child: Text('Article',
                            style: TextStyle(
                                fontSize: 15, color: backgroundcolor)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        child: Text(
                          ' Catégorie',
                          style:
                              TextStyle(fontSize: 15, color: backgroundcolor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Text(
                          'Prix A',
                          style:
                              TextStyle(fontSize: 15, color: backgroundcolor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Text(
                          'Prix V',
                          style:
                              TextStyle(fontSize: 15, color: backgroundcolor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Text(
                          'Gain',
                          style:
                              TextStyle(fontSize: 15, color: backgroundcolor),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete, color: Color(0x00000000)),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Color(0x00000000)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _buildListView()),
              ],
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    tileColor: Color(0xFF15171e),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          child: Text('Catégorie',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: backgroundcolor)),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.update, color: Color(0x00000000)),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete, color: Color(0x00000000)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: _buildListCategorieView()),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF455A64),
            child: Text(
              '+',
              style: TextStyle(fontSize: 30),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            }),
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('product').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: Hive.box('product').length,
          itemBuilder: (context, index) {
            final products = Hive.box('product').getAt(index) as NewProduct;
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    child: Text(products.name,
                        style: TextStyle(fontSize: 16, color: buttoncolor),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    child: Text(products.categorie.toString(),
                        style: TextStyle(fontSize: 16, color: buttoncolor),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: Text(
                      products.buyingPrice.toString(),
                      style: TextStyle(fontSize: 15, color: buttoncolor),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: Text(products.sellingPrice.toString(),
                        style: TextStyle(fontSize: 15, color: buttoncolor),
                        textAlign: TextAlign.left),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: Text(products.benefit.toString(),
                        style: TextStyle(fontSize: 15, color: buttoncolor),
                        textAlign: TextAlign.left),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFF2FDD92),
                      ),
                      onPressed: () {
                        Hive.box('product').getAt(index);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, setState) => AlertDialog(
                                  content: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  //fontSize: 20,
                                                  color: buttoncolor,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white10,
                                                  labelText: 'Nom',
                                                  labelStyle: TextStyle(
                                                      color: buttoncolor,
                                                      fontSize: 13),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: buttoncolor),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                onSaved: (value) =>
                                                    _nameup = value,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'SVP entrez un nom valide';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 30),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  //fontSize: 20,
                                                  color: buttoncolor,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white10,
                                                  labelText: 'prix d\'achat',
                                                  labelStyle: TextStyle(
                                                      color: buttoncolor,
                                                      fontSize: 13),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: buttoncolor),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                onSaved: (value) =>
                                                    _buyingPriceup = value,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'SVP entrez un nom valide';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  //fontSize: 20,
                                                  color: buttoncolor,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white10,
                                                  labelText: 'prix de vente',
                                                  labelStyle: TextStyle(
                                                      color: buttoncolor,
                                                      fontSize: 13),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: buttoncolor),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                onSaved: (value) =>
                                                    _sellingPriceup = value,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'SVP entrez un nom valide';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[600]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: DropdownButton(
                                                  value: val,
                                                  isExpanded: true,
                                                  items: RetListforupdate()
                                                      .map((ele) {
                                                    return DropdownMenuItem(
                                                      value: ele,
                                                      child: Text(ele),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) =>
                                                      setState(() {
                                                    this.val = value;
                                                  }),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  buttoncolor)),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _formKey.currentState
                                                          .save();
                                                      final _benefitup = int.parse(
                                                              _sellingPriceup) -
                                                          int.parse(
                                                              _buyingPriceup);
                                                      print(_benefitup);
                                                      final newproduct = NewProduct(
                                                          _nameup,
                                                          int.parse(
                                                              _buyingPriceup),
                                                          int.parse(
                                                              _sellingPriceup),
                                                          _benefitup,
                                                          val);
                                                      updateProduct(
                                                          index, newproduct);
                                                      _formKey.currentState
                                                          .reset();
                                                      Toast.show(
                                                          "Produit sauvegardé avec succès",
                                                          context,
                                                          duration: 2,
                                                          gravity: Toast.BOTTOM,
                                                          textColor: Color(
                                                              0xFF66FCF1));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 13.0,
                                                              bottom: 13),
                                                      child: Text(
                                                        'Modifier produit',
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color(0xFFf45858),
                      ),
                      onPressed: () {
                        Hive.box('product').deleteAt(index);
                        Toast.show("Produit supprimé avec succès", context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            textColor: Color(0xFF66FCF1));
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

  Widget _buildListCategorieView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('categorie').listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
            itemCount: Hive.box('categorie').length,
            itemBuilder: (context, index) {
              final catList = Hive.box('categorie').getAt(index) as Categorie;
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(catList.categorie,
                          style: TextStyle(
                            fontSize: 16,
                            color: buttoncolor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.update,
                          color: Color(0xFF2FDD92),
                        ),
                        onPressed: () {
                          Hive.box('categorie').getAt(index);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  //fontSize: 20,
                                                  color: buttoncolor,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white10,
                                                  labelText: 'Catégorie',
                                                  labelStyle: TextStyle(
                                                      color: buttoncolor,
                                                      fontSize: 13),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: buttoncolor),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                onSaved: (value) =>
                                                    categorieName = value,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'SVP entrez un nom valide';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 30),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  buttoncolor)),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _formKey.currentState
                                                          .save();

                                                      final newcategorie =
                                                          Categorie(
                                                              categorieName);
                                                      updateCategorie(
                                                          newcategorie, index);
                                                      _formKey.currentState
                                                          .reset();
                                                      Toast.show(
                                                          "categorie modifiée avec succès",
                                                          context,
                                                          duration: 1,
                                                          gravity: Toast.BOTTOM,
                                                          textColor: Color(
                                                              0xFF66FCF1));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 13.0,
                                                              bottom: 13),
                                                      child: Text(
                                                        'Ajouter Une Catégorie',
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Color(0xFFf45858),
                        ),
                        onPressed: () {
                          Hive.box('categorie').deleteAt(index);
                          Toast.show("categorie supprimée avec succès", context,
                              duration: 2,
                              gravity: Toast.BOTTOM,
                              textColor: Color(0xFF66FCF1));
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}