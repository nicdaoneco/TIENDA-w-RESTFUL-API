import 'package:TIENDA/Cproduct.dart';
import 'package:TIENDA/viewbeverages.dart';
import 'package:TIENDA/viewcanned.dart';
import 'package:TIENDA/viewfoodpack.dart';
import 'package:TIENDA/viewfrozen.dart';
import 'package:TIENDA/viewmedicine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllProducs extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducs> {
  @override
  Widget build(BuildContext context) {
    final available = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
      child: Text(
        "IF YOU WANT TO ADD A PRODUCT, INPUT VALID CATEGORY  :  FROZEN, CANNED, PACKED, BEVERAGES, PHARMACEUTICAL ",
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Caveat'),
      ),
    );
    final canned = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('CANNED',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Canned();
                },
              ),
            );
          },
        ),
      ),
    );
    final frozen = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('FROZEN',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Frozen();
                },
              ),
            );
          },
        ),
      ),
    );
    final food = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text(' PACKED',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Pack();
                },
              ),
            );
          },
        ),
      ),
    );
    final medicine = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('MEDICINE',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Medicine();
                },
              ),
            );
          },
        ),
      ),
    );
    final beverages = Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('BEVERAGES',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Beverages();
                },
              ),
            );
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PRODUCT CATEGORY',
          textAlign: TextAlign.center,
        ),
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
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            available,
            canned,
            frozen,
            food,
            beverages,
            medicine,
          ],
        ),
      ),
    );
  }
}
