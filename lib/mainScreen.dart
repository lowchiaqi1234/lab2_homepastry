import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast_renameuiviewtoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'cartpage.dart';
import 'loginScreen.dart';
import 'myDrawer.dart';
import 'user.dart';
import 'dart:convert';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight, screenWidth;
  List _productList;
  String _title = "Loading...";
  int cartitem = 0;
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _testasync();

  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text('Home Page'),
            centerTitle: true,
            actions: [
              TextButton.icon(
                  onPressed: () => {_cart()},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  label: Text(
                    cartitem.toString(),
                    style: TextStyle(color: Colors.black),
                  )),
            ],
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
              Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                child: Column(children: [
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search product",
                      suffixIcon: IconButton(
                        onPressed: () => _loadproduct(_searchController.text),
                        icon: Icon(Icons.search),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: BorderSide(color: Colors.orange),
                          gapPadding: 20),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.orange)),
                    ),
                  ),
                ]),
              )),
              _productList == null
                  ? Flexible(child: Center(child: Text(_title)))
                  : Flexible(child:
                      OrientationBuilder(builder: (context, orientation) {
                      return StaggeredGridView.countBuilder(
                          padding: EdgeInsets.all(15),
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 1,
                          itemCount: _productList.length,
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 5.0,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(children: [
                              Container(
                                  child: Card(
                                elevation: 10,
                                child: SingleChildScrollView(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: screenHeight / 6.0,
                                      width: screenWidth / 0.3,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://lowtancqx.com/s270910/homepastry/images/${_productList[index]['prid']}.jpeg",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                                Icons.broken_image,
                                                size: screenWidth / 3,
                                              )),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          GestureDetector(
                                            child: Text(
                                                "   " +
                                                    _productList[index]
                                                        ["prname"] +
                                                    "   ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange[700])),
                                          ),
                                          GestureDetector(
                                            child: Text(
                                                "(" +
                                                    _productList[index]
                                                        ["prtype"] +
                                                    ")",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    color: Colors.orange[700])),
                                          ),
                                        ]),
                                    SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "      Price                   :  ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            child: Text(
                                                " RM " +
                                                    _productList[index]
                                                        ["prprice"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.brown[400])),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "      Quantity             :    \n",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            child: Text(
                                                _productList[index]["prqty"] +
                                                    "             \n",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.brown[400])),
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            minWidth: 80,
                                            height: 40,
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () => {_order(index)},
                                            color: Colors.orange,
                                          ),
                                        ]),
                                    SizedBox(height: 5),
                                  ],
                                )),
                              ))
                            ]);
                          });
                    }))
            ])),
          ),
        ));
  }

  _loadproduct(String prname) {
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/loadproduct.php"),
        body: {"prname": prname}).then((response) {
      if (response.body == "nodata") {
        _title = "Sorry no product available";
        _productList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _productList = jsondata["products"];
        setState(() {
          print(_productList);
        });
      }
    });
  }

  Future<void> _testasync() async {
    _loadproduct("all");
    _loadCart();
  }

  _cart() {
    Navigator.of(context).push( MaterialPageRoute(builder: (contemt) => CartPage(user: widget.user)));
  _loadproduct("all");
  }

  _order(int index) async {
    await Future.delayed(Duration(seconds: 1));
    String email = widget.user.email;
    String prid = _productList[index]['prid'];
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/insertproduct.php"),
        body: {"email": email, "prid": prid}).then((response) {
      print(response.body);
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[400],
            textColor: Colors.white,
            fontSize: 16.0);
        _loadCart();
      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to back to login page?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (content) => LoginScreen()));
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(color: Colors.red[400]),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.teal[400]),
                  )),
            ],
          ),
        ) ??
        false;
  }

  void _loadCart() {
      String email = widget.user.email;
   http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/loadcart.php"),
        body: {"email": email}).then((response) {
      setState(() {
        cartitem = int.parse(response.body);
        print(cartitem);
      });
    });
  }
}
