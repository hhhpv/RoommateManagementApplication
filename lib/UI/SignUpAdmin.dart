import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomate/UI/signup.dart';

class SignUpAdminForm extends StatefulWidget {
  @override
  _SignUpAdminFormState createState()=> _SignUpAdminFormState();
}
class _SignUpAdminFormState extends State<SignUpAdminForm>{
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
                        "Go Back",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontFamily: "Ubuntu", fontWeight: FontWeight.w900, fontSize: 12),
                      ),
                        onPressed: ()=> {
                          Navigator.of(context).push(new MaterialPageRoute(builder:
                              (BuildContext context) => new SignUpForm()
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