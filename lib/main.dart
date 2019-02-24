import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ipsas_jee/articles_view.dart';
import 'package:ipsas_jee/model/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[700],
          accentColor: Colors.orange[600]),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email = '', _password = '';
  bool isLoading = false, _loginError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              SizedBox(height: 120),
              emailTextField(),
              SizedBox(height: 40),
              passwordTextField(),
              SizedBox(height: 40),
              _loginError
                  ? Text(
                      "Please check your credentials ",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).accentColor,
                    )
                  : RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: loginUser,
                    )
            ],
          )),
    );
  }

  TextField passwordTextField() {
    return TextField(
      onChanged: (passwordField) => _password = passwordField,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Your password...',
      ),
    );
  }

  TextField emailTextField() {
    return TextField(
      onChanged: (emailField) => _email = emailField,
      decoration: InputDecoration(hintText: 'Your email...'),
      keyboardType: TextInputType.emailAddress,
    );
  }

  void loginUser() {
    setState(() {
      isLoading = true;
    });
    http.post('http://10.0.2.2:8989/ipsas-jee/restWS/api/login',
        body: json.encode({'login': _email, 'password': _password}),
        headers: {'Content-Type': 'application/json'}).then((response) async {
      setState(() {
        isLoading = false;
      });
      if (response == null) {
        setState(() {
          _loginError = true;
        });
      } else {
        _loginError = false;
        Map clientMap = jsonDecode(response.body);
        Client client = Client.fromJson(clientMap);
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('clientId', client.id);
        MaterialPageRoute _route =
            MaterialPageRoute(builder: (context) => ArticlesView());
        Navigator.of(context).pushReplacement(_route);
      }
    }).catchError((err) {
      setState(() {
        isLoading = false;
        _loginError = true;
      });
      print(err);
    });
  }
}
