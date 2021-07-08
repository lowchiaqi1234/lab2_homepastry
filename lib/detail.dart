import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homepastry/user.dart';

import 'myDrawer.dart';
 
void main() => runApp(Detail());
 
class Detail extends StatefulWidget {
  final User user;

  const Detail({Key key, this.user}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  double screenHeight, screenWidth;
  List _productList;
  String _title = "Loading...";

    @override
  void initState() {
    super.initState();
    _testasync();

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
          title: Text('Pastry Detail'),
        ),
        drawer: MyDrawer(user: widget.user),
         body: Center(
          child: Container(
            child: Column(
              children: [
              
                  _productList == null
              ? Flexible(child: Center(child: Text(_title)))
              : Flexible(child:
                      OrientationBuilder(builder: (context, orientation) {
                      return GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 1,
                          children: List.generate(_productList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.all(2),
                                child: Container(
                                    child: Card(
                                        elevation: 5,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
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
                                                      "https://lowtancqx.com/s270910/homepastry/images/${_productList[index]['prid']}.jpeg",
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
                                                        _productList[index]
                                                            ['prname'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                       _productList[index]
                                                            ['prtype'],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            backgroundColor:
                                                                Colors.yellow,
                                                            color: Colors
                                                                .orange[700])),
                                                    SizedBox(height: 5),
                                                    Text(
                                                       _productList[index]
                                                            ['prdes'],
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            )),
                                                    
                                                  ],
                                                ),
                                              ),
                                            ),
                                            
                                          ],
                                        ))));
                          }));
                    })),
                
              ],
            )
          ),
        ),
      ),
    );
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
    
  }
}