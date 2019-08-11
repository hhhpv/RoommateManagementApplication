import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roomate/UI/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomate/UI/signup.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState()=> _LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loggedIn=false;
  var response,result,r;

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn=prefs.getBool("loggedIn") ?? false;
    if(loggedIn){
      Route home = MaterialPageRoute(builder: (context) => Home());
      Navigator.of(context).pushReplacementNamed('/homescreen');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkLoginStatus();
    debugPrint("hello");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    void  login() async {
      Map data = {
        "username":nameController.text,
        "email":emailController.text,
        "password":passwordController.text,
      };
      response = await http.post("http://192.168.1.162:4000/login/room-login",headers: {'Content-type': 'application/json'},
          body: jsonEncode(data));
      r=(jsonDecode(response.body));
      debugPrint(r['result']);
      result=r['result'];
      setState(() {
      });
    }

    _StoreCurrentUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', nameController.text);
      await prefs.setString('email', emailController.text);
      await prefs.setString('token', r['data']['token']);
      await prefs.setString('groupId', r['data']['groupId']);
      await prefs.setBool("loggedIn", true);
    }
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.green.withAlpha(4000),
      body: Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context)
    {
    return new Center(child:
    new ListView(children: <Widget>[
    new Padding(padding: EdgeInsets.fromLTRB(0, 150.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller:nameController,decoration: InputDecoration(hintText: ' Enter your name',labelText: "Name: ",contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),style: new TextStyle(fontSize: 25.0,fontFamily: "Lobster"),)
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller: emailController,decoration: InputDecoration(hintText: ' Enter your email',labelText: "Email: ",contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),style: new TextStyle(fontSize: 25.0,fontFamily: "Lobster"),)
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
    child:new TextField(controller:passwordController ,obscureText:true,decoration: InputDecoration(hintText: ' Enter your Password',labelText: "Password: ",contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),style: new TextStyle(fontSize: 25.0,fontFamily: "Lobster"),)
    ),

    new Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),

    new Container(
    margin: EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
    child:new RaisedButton(child: new Text("LOGIN",style: new TextStyle(fontFamily: "Ubuntu",fontWeight: FontWeight.w900,fontSize: 15),)
    ,onPressed: () {
    String info=nameController.text+" "+emailController.text+" "+passwordController.text;
    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
    info="password match";
    login();
    if(result=="success"){
      _StoreCurrentUser();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Home()));
    }else{
      final snackBar = SnackBar(
        content: Text('Signing You Up!'),
        action: SnackBarAction(
          label: r['data']['message'],
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
    }
    },),),

      new FlatButton(onPressed: ()=>{Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new SignUpForm()))}, child: Text("New User? SignUp Here",style: new TextStyle(fontSize: 12,fontFamily: "Ubuntu"),))

      ,new Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),

    ])
    );
    })
    );
  }


}