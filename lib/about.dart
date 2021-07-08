import 'package:flutter/material.dart';
import 'package:homepastry/user.dart';

import 'myDrawer.dart';

void main() => runApp(About());

class About extends StatefulWidget {
  final User user;

  const About({Key key, this.user}) : super(key: key);
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('ABOUT US'),
          backgroundColor: Color(0x44000000),
          centerTitle: true,
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/images/picture.jpeg', scale: 1.3),
              SizedBox(height: 20),
              Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    child: Column(children: [
                      
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("  HOME PASTRY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.orange[700])),
                          ]),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: new SingleChildScrollView(
                              child: RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      text:
                                          " Hi, Welcome to Home Pastry Market, that have sell various type of pastry products such as cakes, dessert, bread etc. It's also provide a delivery service in HomePastry.")),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("  CONTACtT US",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.orange[700])),
                          ]),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("  Phone Number:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("   60114960159",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("  Email:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("                    homepastry@gmail.com",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ]),
                          SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("  WeChat:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("                 pastry6688",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ]),
                          SizedBox(height: 30),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                         
                           children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: new SingleChildScrollView(
                              child: RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      text:
                                          "Feel free to contact us, if you have any questions :)")),
                             ),
                          )
                        ],
                      ),
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
