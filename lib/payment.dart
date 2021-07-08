import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homepastry/user.dart';
import 'package:webview_flutter/webview_flutter.dart';
 
void main() => runApp(Payment());
 
class Payment extends StatefulWidget {
  final User user;

  const Payment({Key key, this.user}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
   Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Payment'),
          backgroundColor: Colors.orangeAccent,
        ),
         body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://lowtancqx.com/s270910/homepastry/php/generate_bill.php?email=' +
                          widget.user.email +
                          '&mobile=' +
                          widget.user.phone +
                          '&name=' +
                          widget.user.username +
                          '&amount=' +
                          widget.user.amount,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}

 