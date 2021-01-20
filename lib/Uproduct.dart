import 'package:TIENDA/allproduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  var _nameController = new TextEditingController();
  var _categoryController = new TextEditingController();
  var _priceController = new TextEditingController();
  var _qtyController = new TextEditingController();
  var _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Record"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(padding: EdgeInsets.all(30), children: <Widget>[
      SizedBox(
        height: 30,
      ),
      TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: "Name",
        ),
      ),
      SizedBox(
        height: 30,
      ),
      TextField(
        controller: _categoryController,
        decoration: InputDecoration(
          hintText: "Category",
        ),
      ),
      SizedBox(
        height: 30,
      ),
      TextField(
        controller: _priceController,
        decoration: InputDecoration(
          hintText: "Price",
        ),
      ),
      SizedBox(
        height: 30,
      ),
      TextField(
        controller: _qtyController,
        decoration: InputDecoration(
          hintText: "Quantity",
        ),
      ),
      TextField(
        controller: _descriptionController,
        decoration: InputDecoration(
          hintText: "Description",
        ),
      ),
      SizedBox(
        height: 30,
      ),
      FlatButton(
          onPressed: () {
            _addproduct();
          },
          child: Text("Done")),
    ]);
  }

  _addproduct() async {
    var response = await http.put(Uri.encodeFull(

        //laravel api

        "http://192.168.0.25:8000/api/products/"), headers: {
      "Accept": "application/json"
    }, body: {
      "name": _nameController.text,
      "category": _categoryController.text,
      "price": _priceController.text,
      "qty": _qtyController.text,
      "description": _descriptionController.text
    });
    var data = json.decode(response.body);
    print(data);
    var alert = new AlertDialog(
      title: new Text("Successfully Updated a Product!!!"),
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
}
