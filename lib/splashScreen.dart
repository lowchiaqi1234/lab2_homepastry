import 'dart:async';

import 'package:flutter/material.dart';

import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(children: <Widget>[
            SizedBox(height: 200),
            Image.asset(
              'assets/images/logohomepastry.png',
              scale: 1.0,
            ),
            SizedBox(height: 260),
            Text(
              "by Home Pastry",
              style: TextStyle(
                fontSize: 15,
                color: Colors.brown[800],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
