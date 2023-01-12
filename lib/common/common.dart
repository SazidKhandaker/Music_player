import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToseterDemo extends StatefulWidget {
  String ? title;
ToseterDemo(this.title);
  @override
  State<ToseterDemo> createState() => _ToseterDemoState();
}

class _ToseterDemoState extends State<ToseterDemo> {
  @override
  Widget build(BuildContext context) {
    return fctn("${widget.title}");
  }



fctn(String title1,){

  return  Fluttertoast.showToast(
        msg: "${title1}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
}