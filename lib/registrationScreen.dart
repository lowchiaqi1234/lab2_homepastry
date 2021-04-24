import 'package:flutter/material.dart';
import 'package:fluttertoast_renameuiviewtoast/fluttertoast.dart';
import 'loginScreen.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreen createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
   TextEditingController _cpasswordController = new TextEditingController();

  bool _isChecked = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('REGISTRATION'),
        ),
        backgroundColor: Colors.orange[50],
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Text("REGISTER ACCOUNT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.orange[700])),
                  Text("Complete the detail below"),
                  SizedBox(height: 30),
                  TextField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your username",
                        icon: Icon(Icons.person),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange),
                            gapPadding: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange)),
                      )),
                  SizedBox(height: 30),
                  TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        icon: Icon(Icons.email),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange),
                            gapPadding: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange)),
                      )),
                  SizedBox(height: 30),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        icon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: _togglePass,
                          child: Icon(Icons.visibility),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange),
                            gapPadding: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange))),
                    obscureText: _obscureText,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _cpasswordController,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Enter your password again",
                        icon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: _togglePass,
                          child: Icon(Icons.visibility),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange),
                            gapPadding: 20),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.orange))),
                    obscureText: _obscureText,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool value) {
                            _onChange(value);
                          }),
                      GestureDetector(
                        onTap: _showEULA,
                        child: Text('I Agree to Terms (Click here)',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: 300,
              height: 50,
              child: Text(
                "REGISTER",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: _onRegister,
              color: Colors.orange,
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Already Register?  ", style: TextStyle(fontSize: 16)),
              GestureDetector(
                child: Text("Login NOW!",
                    style: TextStyle(fontSize: 16, color: Colors.orange[900])),
                onTap: _alreadyRegister,
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (contemt) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _onRegister() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    String _username = _usernameController.text.toString();
    String _cpassword = _cpasswordController.text.toString();

    if (_email.isEmpty || _password.isEmpty || _username.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please complete your detail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    } if (!validateEmail(_email)) {
      Fluttertoast.showToast(
          msg: "Invaild Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept terms to continue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } if (_password != _cpassword) {
      Fluttertoast.showToast(
          msg: "The password are not same",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
   

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Register new user."),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                child: Text("YES", style: TextStyle(color: Colors.deepOrange)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_username, _email, _password);
                },
              ),
              TextButton(
                  child: Text("NO", style: TextStyle(color: Colors.deepOrange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _registerUser(String username, String email, String password) {
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/register_user.php"),
        body: {
          "username": username,
          "email": email,
          "password": password,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Register Success, Please check your email for verification link and try to login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[300],
            textColor: Colors.white,
            fontSize: 16.0);

        return;
      } else {
        Fluttertoast.showToast(
            msg: "Register Failed, Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);

        return;
      }
    });
  }

  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showEULA() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("EULA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          content: new Container(
            child: Column(
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
                              fontSize: 15.0,
                            ),
                            text:
                                "This End-User License Agreementis a legal agreement between you and Pastry. Our EULA was created by EULA Template for homepastry.This EULA agreement governs your acquisition and use of our homepastry software  directly from Pastry or indirectly through a Pastry authorized reseller or distributor. Our Privacy Policy was created by the Privacy Policy Generator.Please read this EULA agreement carefully before completing the installation process and using the homepastry software. It provides a license to use the homepastry software and contains warranty information and liability disclaimers.If you register for a free trial of the homepastry software, this EULA agreement will also govern that trial. By clicking 'accept' or installing and/or using the homepastry software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Pastry herewith regardless of whether other software is referred to or described herein. The terms also apply to any Pastry updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.")),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                "CLOSE",
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  bool validateEmail(String value) {
      
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

}
