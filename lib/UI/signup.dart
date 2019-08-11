import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomate/UI/SignUpAdmin.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState()=> _SignUpFormState();
}
class _SignUpFormState extends State<SignUpForm>{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final groupIdController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var response;
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      passwordController.dispose();
      rePasswordController.dispose();
      groupIdController.dispose();
      super.dispose();
    }
    void  signup() async {
      Map data = {
        "username":nameController.text,
        "email":emailController.text,
        "password":passwordController.text,
        "groupId":groupIdController.text
      };
      response = await http.post("http://192.168.1.162:4000/signUp/user",headers: {'Content-type': 'application/json'},
          body: jsonEncode(data));
      var r=(jsonDecode(response.body));
      debugPrint(r.toString());
      setState(() {
      });
    }
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.green.withAlpha(4000),
      body:Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context)
    {
    return new Center(child:
    new ListView(children: <Widget>[
    new Padding(padding: EdgeInsets.fromLTRB(0, 150.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller:nameController,decoration: InputDecoration(hintText: ' Enter your name',labelText: "Name: ", contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)), style: new TextStyle(fontSize: 25.0
    , fontFamily: "Lobster"), )
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller: emailController, decoration: InputDecoration(hintText: ' Enter your email', labelText: "Email: ", contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)), style: new TextStyle(fontSize: 25.0, fontFamily:
    "Lobster"), )
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller:passwordController, obscureText:true, decoration: InputDecoration(hintText: ' Enter your Password', labelText: "Password: ", contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),style: new TextStyle(fontSize: 25.0, fontFamily
        : "Lobster"), )
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller: rePasswordController, obscureText:true, decoration: InputDecoration(hintText: ' Confirm Password', labelText: "Re-Type Password: ", contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)), style: new TextStyle(fontSize: 25.0,
    fontFamily: "Lobster"), )
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),

      new Container(
          margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
          child:new TextField(controller: groupIdController, obscureText:true, decoration: InputDecoration(hintText: ' Enter GroupID', labelText: "GroupID: ", contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)), style: new TextStyle(fontSize: 25.0,
              fontFamily: "Lobster"), )
      ),

      new Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
    child:new RaisedButton(child: new Text("SIGN UP", style: new TextStyle(fontFamily: "Ubuntu", fontWeight: FontWeight.w900, fontSize: 15), )
    , onPressed: () {
    String info=nameController.text+" "+emailController.text+" "+passwordController.text+" "+rePasswordController.text;
    if(passwordController.text==rePasswordController.text){
    info="password match";
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
    if(emailValid){
      final snackBar = SnackBar(
      content: Text('Signing You Up!'),
      action: SnackBarAction(
        label: 'Please Wait..',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    signup();
    }else{
      final snackBar = SnackBar(
        content: Text('Invalid E-Mail!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    }
    else{
    info="password mismatch";
    final snackBar = SnackBar(
    content: Text('Password Mismatch'),
    action: SnackBarAction(
    label: 'OK',
    onPressed: () {
    // Some code to undo the change.
    },
    ),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    }

//          return showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                content: Text(info),
//              );
//            },
//          );
    }
    , ), ),
      new Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),
      new Container(
          margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
          child:new FlatButton(
            child: new  Text(
                "Want to create a group? SignUp Here..",
                textAlign: TextAlign.center,
                style: new TextStyle(fontFamily: "Ubuntu", fontWeight: FontWeight.w900, fontSize: 12),
            ),
            onPressed: ()=> {
            Navigator.of(context).push(new MaterialPageRoute(builder:
            (BuildContext context) => new SignUpAdminForm()
            ))
            }
          )
      )

    ])
    );
    }
    )
    );

  }

}