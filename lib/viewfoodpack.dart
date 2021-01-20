import 'dart:convert';
import 'dart:ui';
import 'package:TIENDA/Cproduct.dart';
import 'package:TIENDA/allproduct.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Uproduct.dart';

class Pack extends StatefulWidget {
  @override
  _PackState createState() => _PackState();
}

class _PackState extends State<Pack> {
  var _nameController = new TextEditingController();
  var _categoryController = new TextEditingController();
  var _priceController = new TextEditingController();
  var _qtyController = new TextEditingController();
  var _descriptionController = new TextEditingController();

  Future<List<Product>> _getProduct() async {
    var data = await http.get("http://192.168.0.25:8000/api/products/foodpack");

    var jsondata = json.decode(data.body);

    List<Product> products = [];

    for (var i in jsondata) {
      Product product = Product(i["id"], i["name"], i["category"], i["price"],
          i["qty"], i["description"]);
      products.add(product);
    }
    print(products.length);
    return products;
  }

  _editCategory(BuildContext context, id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packed Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Create();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading.."),
                ),
              );
            } else {
              return Card(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text("Price:" +
                          snapshot.data[index].price +
                          " " +
                          " QTY:" +
                          snapshot.data[index].qty),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            //delete
                            var response = await http.delete(
                              Uri.encodeFull(
                                  //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
                                  //laravel api

                                  "http://192.168.0.25:8000/api/products/delete/${snapshot.data[index].id}"),
                              headers: {"Accept": "application/json"},
                            );
                            print(snapshot.data[index].id);
                            var status = response.body.contains('Fail');
                            var data = json.decode(response.body);
                            print(data['user']);
                            print(data);
                            if (status) {
                              print('delete fail');
                              var alert = new AlertDialog(
                                title: new Text("Cant Delete Account"),
                              );
                              showDialog(context: context, child: alert);
                            } else {
                              print(data['user']);
                              print('User deleted');
                              var alert = new AlertDialog(
                                title: new Text("Account Deleted"),
                              );
                              showDialog(context: context, child: alert);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AllProducs();
                                  },
                                ),
                              );
                            }
                          }),
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text(
                                    'Update ' + '${snapshot.data[index].name}'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _priceController,
                                          decoration: InputDecoration(
                                            labelText: 'Price',
                                            icon: Icon(Icons.attach_money),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _qtyController,
                                          decoration: InputDecoration(
                                            labelText: 'Quantity',
                                            icon:
                                                Icon(Icons.food_bank_outlined),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _categoryController,
                                          decoration: InputDecoration(
                                            labelText: 'Food Category:',
                                            icon: Icon(Icons.border_color),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () async {
                                      // your code
                                      var response = await http.put(
                                          Uri.encodeFull(

                                              //laravel api

                                              "http://192.168.0.25:8000/api/products/update/${snapshot.data[index].id}"),
                                          headers: {
                                            "Accept": "application/json"
                                          },
                                          body: {
                                            "price": _priceController.text,
                                            "qty": _qtyController.text,
                                            "category": _categoryController.text
                                          });

                                      var status =
                                          response.body.contains('Fail');
                                      var data = json.decode(response.body);
                                      print(data);
                                      if (status) {
                                        print('Update Fail');
                                        var alert = new AlertDialog(
                                          title:
                                              new Text("Cant Delete Account"),
                                        );
                                        showDialog(
                                            context: context, child: alert);
                                      } else {
                                        print('Updated Complete');
                                              var alert = new AlertDialog(
                                                title: new Text(
                                                    "Product Updated!"),
                                              );

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Pack();
                                                  },
                                                ),
                                              );
                                              showDialog(
                                                  context: context,
                                                  child: alert);
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _addproduct() async {
    var response = await http.post(Uri.encodeFull(

        //laravel api

        "http://192.168.0.25:8000/api/auth/register"), headers: {
      "Accept": "application/json"
    }, body: {
      "name": _nameController.text,
      "category": _categoryController.text,
      "price": _priceController.text,
      "qty": _qtyController.text,
      "description": _descriptionController.text
    });
  }
}

class Product {
  int id;
  String name;
  String category;
  String price;
  String qty;
  String description;
  Product(this.id, this.name, this.category, this.price, this.qty,
      this.description);
}
