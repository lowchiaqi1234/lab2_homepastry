import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast_renameuiviewtoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:homepastry/user.dart';
import 'package:ndialog/ndialog.dart';

import 'checkoutpage.dart';
import 'myDrawer.dart';

void main() => runApp(CartPage());

class CartPage extends StatefulWidget {
  final User user;

  const CartPage({Key key, this.user}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double screenHeight, screenWidth;
  String _titlecenter = "Loading your cart";
  List _cartList;
  double _totalprice = 0.0;
  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('My Cart'),
          centerTitle: true,
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              _cartList == null
                  ? Flexible(child: Center(child: Text(_titlecenter)))
                  : Flexible(child:
                      OrientationBuilder(builder: (context, orientation) {
                      return GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: 2 / 1,
                          children: List.generate(_cartList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.all(1),
                                child: Container(
                                    child: Card(
                                        elevation: 5,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                height: orientation ==
                                                        Orientation.portrait
                                                    ? 250
                                                    : 150,
                                                width: orientation ==
                                                        Orientation.portrait
                                                    ? 100
                                                    : 150,
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  imageUrl:
                                                      "https://lowtancqx.com/s270910/homepastry/images/${_cartList[index]['prid']}.jpeg",
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 10,
                                                child: VerticalDivider(
                                                  color: Colors.orange,
                                                )),
                                            Expanded(
                                              flex: 6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        _cartList[index]
                                                            ['prname'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        _cartList[index]
                                                            ['prtype'],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            backgroundColor:
                                                                Colors.yellow,
                                                            color: Colors
                                                                .orange[700])),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.remove),
                                                          onPressed: () {
                                                            _modQty(index,
                                                                "removecart");
                                                          },
                                                        ),
                                                        Text(
                                                            _cartList[index]
                                                                ['cartqty'],
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            )),
                                                        IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed: () {
                                                            _modQty(index,
                                                                "addcart");
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "RM " +
                                                          (int.parse(_cartList[
                                                                          index]
                                                                      [
                                                                      'cartqty']) *
                                                                  double.parse(
                                                                      _cartList[
                                                                              index]
                                                                          [
                                                                          'prprice']))
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      _deleteCartDialog(index);
                                                    },
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ))));
                          }));
                    })),
              Container(
                  color: Colors.orange[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5),
                      Divider(
                        color: Colors.black,
                        height: 70,
                      ),
                      Text(
                        "TOTAL",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ": RM " + _totalprice.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[900]),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 25),
                        ),
                        onPressed: () {
                          _checkout();
                        },
                        child: Text("CHECKOUT",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _loadMyCart() {
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/loadusercart.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no product are in the cart";
        _cartList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _cartList = jsondata["cart"];
        _titlecenter = "";
        _totalprice = 0.0;
        for (int i = 0; i < _cartList.length; i++) {
          _totalprice = _totalprice +
              double.parse(_cartList[i]['prprice']) *
                  int.parse(_cartList[i]['cartqty']);
        }
      }
      setState(() {});
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.teal[400]),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.red[400]),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  Future<void> _modQty(int index, String s) async {
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/updatecart.php"),
        body: {
          "email": widget.user.email,
          "op": s,
          "prid": _cartList[index]['prid'],
          "qty": _cartList[index]['cartqty']
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[300],
            textColor: Colors.white,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  Future<void> _deleteCart(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete from cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/deletecart.php"),
        body: {
          "email": widget.user.email,
          "prid": _cartList[index]['prid']
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[300],
            textColor: Colors.white,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _checkout() {
    if (_totalprice == 0.0) {
      Fluttertoast.showToast(
          msg: "Amount not payable",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Proceed with checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes",style: TextStyle(color: Colors.teal[400])),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CheckOutPage(
                                user: widget.user, total: _totalprice),
                          ),
                        );
                      },
                    ),
                    TextButton(
                        child: Text("No",style: TextStyle(color: Colors.deepOrange[400]),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
          context: context);
    }
  }
}
