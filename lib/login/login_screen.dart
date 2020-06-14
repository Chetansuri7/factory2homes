
import 'package:factory2homes/home_screen.dart';
import 'package:factory2homes/login/user_api.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  @override
  void initState() {
    super.initState();
    _setSharedPrefs();
  }

  _setSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('userId', 0);
    _prefs.setString('userName', '');
    _prefs.setString('userEmail', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),

              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(

                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                autofocus: false,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    hintText: 'Enter your password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: Container(
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: ()  async {
                    var email = emailController.text;
                    var password = passwordController.text;
                    setState(() {
                      message = 'Please wait...';
                    });
                    var result = await loginUser(email, password);
                    if(result ['result']== true ){
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setInt('userId', result['user']['id']);
                      _prefs.setString('userName', result['user']['name']);
                      _prefs.setString('userEmail', result['user']['email']);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    } else {
                      print('incorrect password');
                    }

                  },
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(message),
            FlatButton(
              onPressed: () {},
              child: FittedBox(child: Text('Register your account')),
            ),
          ],
        ),
      ),
    );
  }
}
