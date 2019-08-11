import 'package:flutter/material.dart';

class LicenseForm extends StatefulWidget {
  @override
  _LicenseFormState createState()=> _LicenseFormState();
}
class _LicenseFormState extends State<LicenseForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("License"),
        backgroundColor: Colors.teal.shade400,),
      body: new Container(
        child: new Column(children: <Widget>[new Padding(padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0)),
          new Text("\t\t\tLICENSE \n \t\t\t\tTO \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tLEARN.",
            style: new TextStyle(fontSize: 44, fontFamily: "Ubuntu",),textAlign: TextAlign.center,),
        ],)
      ),
    );
  }
}
