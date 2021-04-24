import 'package:flutter/material.dart';
 
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Material App',
      home: Scaffold(
         backgroundColor: Colors.orange[50],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Main Menu'),
        ),
        body: Center(
          child: Container(
            child: Text('HOME PASTRY'),
          ),
        ),
      ),
    );
  }
}