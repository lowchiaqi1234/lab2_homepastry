import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:homepastry/pastrycategory/dessert.dart';
import 'pastrycategory/bread.dart';
import 'myDrawer.dart';
import 'pastrycategory/cake.dart';
import 'pastrycategory/other.dart';
import 'pastrycategory/pastries.dart';
import 'user.dart';

class Category extends StatefulWidget {
  final User user;

  const Category({Key key, this.user}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Category'),
          centerTitle: true,
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: Container(
              child: Column(children: [
            Container(
                height: 150,
                width: 450.0,
                child: Carousel(
                    dotSize: 5.0,
                    dotSpacing: 20.0,
                    dotColor: Colors.orange[700],
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.orange.withOpacity(0.5),
                    borderRadius: true,
                    moveIndicatorFromBottom: 180.0,
                    noRadiusForIndicator: true,
                    images: [
                      AssetImage('assets/images/banner.png'),
                      AssetImage('assets/images/banner3.jpeg'),
                      AssetImage('assets/images/banner2.jpg'),
                    ])),
            SizedBox(height: 35),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 300,
                height: 50,
                child: Text(
                  "Pastries",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _pastries,
                color: Colors.orange[800],
              ),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 300,
                height: 50,
                child: Text(
                  "Cake",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _cake,
                color: Colors.orange[800],
              ),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 300,
                height: 50,
                child: Text(
                  "Bread",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _bread,
                color: Colors.orange[800],
              ),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 300,
                height: 50,
                child: Text(
                  "Dessert",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _dessert,
                color: Colors.orange[800],
              ),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 300,
                height: 50,
                child: Text(
                  "Other",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _other,
                color: Colors.orange[800],
              ),
            ]),
          ])),
        ),
      ),
    );
  }

  void _bread() {
    Navigator.push(context, MaterialPageRoute(builder: (contemt) => Bread()));
  }

  void _dessert() {
    Navigator.push(context, MaterialPageRoute(builder: (contemt) => Dessert()));
  }

  void _pastries() {
    Navigator.push(context, MaterialPageRoute(builder: (contemt) => Patries()));
  }

  void _cake() {
    Navigator.push(context, MaterialPageRoute(builder: (contemt) => Cake()));
  }

  void _other() {
    Navigator.push(context, MaterialPageRoute(builder: (contemt) => Other()));
  }
}
