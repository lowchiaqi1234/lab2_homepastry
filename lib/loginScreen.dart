import 'package:flutter/material.dart';
import 'package:fluttertoast_renameuiviewtoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainScreen.dart';
import 'registrationScreen.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _rememberMe = false;
  bool _obscureText = true;
  SharedPreferences prefs;
  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('LOGIN'),
        ),
        backgroundColor: Colors.orange[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset('assets/images/logohomepastry.png', scale: 1.3),
              SizedBox(height: 30),
              Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                child: Column(
                  children: [
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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                            value: _rememberMe,
                            onChanged: (bool value) {
                              _onChange(value);
                            }),
                        Text("Remember Me",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        Spacer(),
                        GestureDetector(
                          child: Text("Forget Password?",
                              style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline)),
                          onTap: _forgetPassword,
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
                  "LOGIN",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: _onLogin,
                color: Colors.orange,
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account yet?  ",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 30),
                GestureDetector(
                  child: Text("Register NOW!",
                      style:
                          TextStyle(fontSize: 16, color: Colors.orange[900])),
                  onTap: _onRegister,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/login_user.php"),
        body: {
          "email": _email,
          "password": _password,
        }).then((response) {
      print(response.body);
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        List userdata = response.body.split(",");
        User user = User(
            email: _email,
            password: _password,
            username: userdata[1],
            datereg: userdata[2],
            status: userdata[3]);
        Fluttertoast.showToast(
            msg: "Welcome to Home Pastry",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.teal[300],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context,
            MaterialPageRoute(builder: (contemt) => MainScreen(user: user)));
      }
    });

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please complete the detail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    }
    if (!validateEmail(_email)) {
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
  }

  void _onRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (contemt) => RegistrationScreen()));
  }

  void _forgetPassword() {
    TextEditingController _useremailcontroller = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Forgot Your Password?"),
            content: new Container(
                height: 80,
                child: Column(
                  children: [
                    Text("Please enter your email"),
                    TextField(
                      controller: _useremailcontroller,
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email)),
                    )
                  ],
                )),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.orange[800]),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  print(_useremailcontroller.text);
                  if (_useremailcontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please enter your email",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.deepOrange[400],
                        textColor: Colors.white,
                        fontSize: 16.0);

                    return;
                  }
                  if (!validateEmail(_useremailcontroller.text)) {
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
                  _resetPassword(_useremailcontroller.text.toString());
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.orange[800]),
                  child: Text("Cancel", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _onChange(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter your email or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    }
    setState(() {
      _rememberMe = value;
      storePref(value, _email, _password);
    });
  }

  Future<void> storePref(bool value, String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString("email", email);
      await prefs.setString("password", password);
      await prefs.setBool("rememberMe", value);
      Fluttertoast.showToast(
          msg: "Preferences Store",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.teal[400],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      await prefs.setString("email", "");
      await prefs.setString("password", "");
      await prefs.setBool("rememberMe", value);
      Fluttertoast.showToast(
          msg: "Preferences Remove",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepOrange[400],
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        _rememberMe = false;
      });
      return;
    }
  }

  Future<void> loadPref() async {
    prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString("email") ?? '';
    String _password = prefs.getString("password") ?? '';
    _rememberMe = prefs.getBool("rememberMe") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  }

  void _resetPassword(String emailreset) {
    http.post(
        Uri.parse(
            "https://lowtancqx.com/s270910/homepastry/php/forgot_password.php"),
        body: {"email": emailreset}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Password reset completed. Please check your email for further instruction",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.teal[400],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Password reset failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange[400],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
