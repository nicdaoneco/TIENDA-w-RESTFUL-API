import 'dart:convert';

import 'package:TIENDA/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:TIENDA/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Valid extends StatefulWidget {
  @override
  _ValidState createState() => _ValidState();
}

class _ValidState extends State<Valid> {
  final _formKey = GlobalKey<FormState>();
  var _passwordController = new TextEditingController();
  var _usernameController = new TextEditingController();
  var data;
  @override
  Widget build(BuildContext context) {
    final register = Container(
      child: Row(
        children: <Widget>[
          Text('Does not have account?'),
          FlatButton(
            textColor: Colors.blue,
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    final title = Padding(
      padding: EdgeInsets.all(60.0),
      child: Text(
        'Login',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Caveat'),
      ),
    );

    final mainlogo = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/groc.png'),
          fit: BoxFit.cover,
        ),
      ),
    );

    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: (String a) {
          if (a.isEmpty) {
            return "Please Enter your number";
          }
        },
        controller: _usernameController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
          hintText: 'CELL #',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );

    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: (String a) {
          if (a.isEmpty) {
            return "Please Enter your number";
          }
        },
        controller: _passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
            hintText: 'PASSWORD',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
      ),
    );

    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('LOGIN',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _addData(_usernameController.text, _passwordController.text);
            }
          },
        ),
      ),
    );

    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            title,
            MainLogo(),
            inputEmail,
            inputPassword,
            buttonLogin,
            register
          ],
        ),
      ),
    ));
  }

  void onCreatedAccount() {
    var alert = new AlertDialog(
      backgroundColor: Color(0xffF57F17),
      title: new Text(
        'Success!',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30.0),
      ),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('You have created a new Account.'),
          ],
        ),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: new Text(
            'Okay',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Dashboard();
                },
              ),
            );
          },
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

  void _addData(String username, String password) async {
    var response = await http.post(Uri.encodeFull(

        //laravel api

        "http://192.168.0.25:8000/api/auth/login"), headers: {
      "Accept": "application/json"
    }, body: {
      "contact": _usernameController.text,
      "password": _passwordController.text,
    });

    var data = json.decode(response.body);
    var status = response.body.contains('error');
    if (status) {
      print(
          'data: data["Error: Incorrect Username or Password. Please try again."]');
      var alert = new AlertDialog(
        title: new Text("Error"),
        content: new Text("Incorrect Username or Password. Please try again."),
      );
      showDialog(context: context, child: alert);
    } else {
      print(data['user']);
      print(data['access_token']);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', data['access_token']);
      localStorage.setString('user', json.encode(data['user']));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    }
  }
}

class MainLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/tienda.png');
    var image = Image(
      image: assetsImage,
      width: 250,
      height: 250,
    );
    return Container(child: image);
  }
}
