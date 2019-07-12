import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState()=> _LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final rePasswordController = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      passwordController.dispose();
      rePasswordController.dispose();
      super.dispose();
    }

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.green.withAlpha(4000),
      body: new Center(child:
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
              String info=nameController.text+" "+emailController.text+" "+passwordController.text+" "+rePasswordController.text;
              if(passwordController.text==rePasswordController.text){
                info="password match";
              }
              else{
                info="password mismatch";
              }
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(info),
                  );
                },
              );
            },),),

      ])
      ),
    );
  }

}