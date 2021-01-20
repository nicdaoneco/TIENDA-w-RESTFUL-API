import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:TIENDA/allproduct.dart';
import 'package:TIENDA/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.reload();
    var userJson = localStorage.getString('user');
    print(userJson);
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      print(userData);
    });
  }

  Widget build(BuildContext context) {
    final avatar = Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 160,
          child: Image.asset('assets/groc.png'),
        ));

    final user = Container(
      child: Row(
        children: <Widget>[
          Text(
            "Hello ",
            style: TextStyle(color: Colors.black87, fontSize: 25),
          ),
          Text(
            userData != null ? '${userData['contact']}' : '',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'WELCOME TO TIENDA YOUR ONLINE SARI-SARI STORE :) ',
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    );

    final buttonLogout = RaisedButton(
        child: Text(
          'START SHOPPING',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AllProducs();
              },
            ),
          );
        });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  userData != null ? '${userData['contact']}' : '',
                  style: TextStyle(color: Colors.black87, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back_ios),
                title: Text("Sign out"),
                onTap: logOut,
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete Account"),
                onTap: delete,
              ),
            ],
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[user, avatar, description, buttonLogout],
          ),
        ),
      ),
    );
  }

  void logOut() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('access_token');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  void delete() async {
    var response = await http.delete(
      Uri.encodeFull(
          //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
          //laravel api

          "http://192.168.0.25:8000/api/auth/delete/${userData['id']}"),
      headers: {"Accept": "application/json"},
    );

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
            return LoginPage();
          },
        ),
      );
    }
  }
}
