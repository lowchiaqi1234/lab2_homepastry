import 'package:flutter/material.dart';
import 'package:fluttertoast_renameuiviewtoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homepastry/payment.dart';
import 'package:homepastry/user.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'delivery.dart';
import 'mappage.dart';

void main() => runApp(CheckOutPage());

class CheckOutPage extends StatefulWidget {
  final User user;
  final double total;

  const CheckOutPage({Key key, this.user, this.total}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int _radioValue = 0;
  String _delivery = "Pickup";
  bool _statusdel = false;
  bool _statuspickup = true;
  String _selectedtime = "08:00 A.M";
  String _curtime = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController _userlocctrl = new TextEditingController();
  String address = "";
  double screenHeight, screenWidth;
  SharedPreferences prefs;
  String _phone = "click to set";

  @override
  void initState() {
    super.initState();
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    _loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String today = DateFormat('hh:mm a').format(now);
    String todaybanner = DateFormat('dd/MM/yyyy').format(now);
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Payment Checkout'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
                    child: Image.asset(
                      'assets/images/banner.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            child: Text(todaybanner,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.orange[900],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Divider(
            height: 0.5,
            color: Colors.orange[900],
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 7,
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "CUSTOMER DETAILS",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Email :",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(
                              flex: 7,
                              child: Text(
                                widget.user.email,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Name :",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                height: 10,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(
                              flex: 7,
                              child: Text(
                                widget.user.username,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Phone :",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                height: 10,
                                child: VerticalDivider(color: Colors.grey)),
                            Expanded(
                              flex: 7,
                              child: GestureDetector(
                                  onTap: () => {phoneDialog()},
                                  child: Text(_phone)),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.orange[50],
                  height: 2,
                ),
                Container(
                  margin: EdgeInsets.all(1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Text(
                          "DELIVERY METHOD",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pickup"),
                            new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                            Text("Delivery"),
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.orange[900],
                  height: 1,
                ),
                Visibility(
                  visible: _statuspickup,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            "PICKUP TIME",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[900]),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.all(3),
                            width: 500,
                            child: Text(
                                "Pickup time daily from 8.00 A.M to 7.00 P.M from our store. Please allow 15-30 minutes to prepare your order before pickup time",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(" Current Time: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  height: 10,
                                  child: VerticalDivider(color: Colors.orange)),
                              Expanded(
                                flex: 5,
                                child: Text(today,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(" Pickup Time: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  height: 10,
                                  child: VerticalDivider(color: Colors.orange)),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(_selectedtime,
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                      Container(
                                          child: IconButton(
                                              iconSize: 30,
                                              icon: Icon(
                                                  Icons.access_time_rounded),
                                              onPressed: () => {
                                                    _selectTime(
                                                      context,
                                                    )
                                                  })),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _statusdel,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            "DELIVERY ADDRESS",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[900]),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _userlocctrl,
                                        style: TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Search or enter address'),
                                        keyboardType: TextInputType.multiline,
                                        minLines:
                                            4, //Normal textInputField will be displayed
                                        maxLines:
                                            4, // when user presses enter it will adapt to it
                                      ),
                                    ],
                                  )),
                              Container(
                                  height: 120,
                                  child: VerticalDivider(color: Colors.orange)),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Colors.orange, // background
                                            onPrimary:
                                                Colors.white, // foreground
                                          ),
                                          onPressed: () =>
                                              {_getUserCurrentLoc()},
                                          child: Text("Location"),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.orange,
                                        height: 2,
                                      ),
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Colors.orange, // background
                                            onPrimary:
                                                Colors.white, // foreground
                                          ),
                                          onPressed: () async {
                                            Delivery _del =
                                                await Navigator.of(context)
                                                    .push(
                                              MaterialPageRoute(
                                                builder: (context) => Mappage(),
                                              ),
                                            );
                                            print(address);
                                            setState(() {
                                              _userlocctrl.text = _del.address;
                                            });
                                          },
                                          child: Text("Map"),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.orange[900],
                  height: 2,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
              color: Colors.orange[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.black,
                    height: 20,
                  ),
                  Row(children: [
                    Text(
                      "TOTAL PAYMENT",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Row(children: [
                    Text(
                      ": RM " + widget.total.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]),
                    )
                  ]),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    ),
                    onPressed: () {
                      _paynowDialog();
                      //payment buttion
                    },
                    child: Text("ORDER",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _delivery = "Pickup";
          _statusdel = false;
          _statuspickup = true;
          setPickupExt();
          break;
        case 1:
          _delivery = "Delivery";
          _statusdel = true;
          _statuspickup = false;
          break;
      }
      print(_delivery);
    });
  }

  void setPickupExt() {
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    setState(() {});
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    final now = new DateTime.now();
    print("NOW: " + now.toString());
    String year = DateFormat('y').format(now);
    String month = DateFormat('M').format(now);
    String day = DateFormat('d').format(now);

    String _hour, _minute, _time = "";
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _selectedtime = _time;
        _curtime = DateFormat("Hm").format(now);

        _selectedtime = formatDate(
            DateTime(int.parse(year), int.parse(month), int.parse(day),
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        int ct = _convMin(_curtime);
        int st = _convMin(_time);
        int diff = st - ct;
        if (diff < 30) {
          Fluttertoast.showToast(
              msg: "Invalid time selection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepOrange[400],
              textColor: Colors.white,
              fontSize: 16.0);
          _selectedtime = _minToTime(ct);
          setState(() {});
          return;
        }
      });
  }

  int _convMin(String c) {
    var val = c.split(":");
    int h = int.parse(val[0]);
    int m = int.parse(val[1]);
    int tmin = (h * 60) + m;
    return tmin;
  }

  String _minToTime(int min) {
    var m = min + 30;
    var d = Duration(minutes: m);
    List<String> parts = d.toString().split(':');
    String tm = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    return DateFormat.jm().format(DateFormat("hh:mm").parse(tm));
  }

  _getUserCurrentLoc() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
    progressDialog.dismiss();
  }

  void _getPlace(Position pos) async {
    List<Placemark> newPlace = await GeocodingPlatform.instance
        .placemarkFromCoordinates(pos.latitude, pos.longitude,
            localeIdentifier: "en");

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    _userlocctrl.text = address;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _paynowDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Pay for RM ' + widget.total.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes", style: TextStyle(color: Colors.teal[400])),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Payment(
                            user: User(
                                email: widget.user.email,
                                username: widget.user.username,
                                phone: _phone,
                                amount: widget.total.toStringAsFixed(2)),
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                      child: Text("No", style: TextStyle(color: Colors.deepOrange[400])),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void phoneDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter your phone number"),
            content: new Container(
              height: 50,
              width: 300,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Enter your phone",
                       icon: Icon(Icons.phone),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.orange),
                            gapPadding: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("OK", style: TextStyle(color: Colors.orange[900])),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _phone = phoneController.text;

                  prefs = await SharedPreferences.getInstance();
                  await prefs.setString("phone", _phone);

                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    _phone = prefs.getString("phone") ?? 'click to set';
    setState(() {});
  }
}
