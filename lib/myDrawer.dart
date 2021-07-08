import 'package:flutter/material.dart';
import 'package:homepastry/about.dart';
import 'package:homepastry/cartpage.dart';
import 'package:homepastry/detail.dart';
import 'package:homepastry/loginScreen.dart';
import 'package:homepastry/user.dart';

import 'category.dart';
import 'mainScreen.dart';

class MyDrawer extends StatefulWidget {
  final User user;

  const MyDrawer({Key key, this.user}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(widget.user.email,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
          decoration: BoxDecoration(color: Colors.orange),
          accountName: Text(widget.user.username,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(Icons.category),
            title: Text("Category"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => Category(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => CartPage(
                            user: widget.user,
                          )));
            }),
         ListTile(
            leading: Icon(Icons.shop_two_outlined),
            title: Text("Detail"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => Detail(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (content) => About(user: widget.user,)));
            }),
        ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (content) => LoginScreen()));
            })
      ],
    ));
  }
}
