import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

 
class Cake extends StatefulWidget {
  @override
  _CakeState createState() => _CakeState();
}

class _CakeState extends State<Cake> {double screenHeight, screenWidth;
  String _title = "Loading...";
  List _productList;
  @override
  void initState() {
    super.initState();
    _loadproduct();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Cake',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Cake'),
        ),
        body: Center(
          child: Container(
              child: Column(
            children: [
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
                                            onPressed: _order,
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
            ],
          )),
        ),
      ),
    );
  }

  void _loadproduct() {
    http.post(
        Uri.parse("https://lowtancqx.com/s270910/homepastry/php/loadcake.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _title = "Sorry no product available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        setState(() {
          print(_productList);
        });
      }
    });
  }

  void _order() {}
}