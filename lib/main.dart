import 'package:flutter/material.dart';
import 'package:roomate/UI/home.dart';
import 'package:roomate/UI/signup.dart';
import 'package:roomate/UI/login.dart';
import 'package:roomate/UI/join_leave.dart';
import 'package:roomate/UI/manage_expense.dart';
import 'package:roomate/UI/view_expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: new LoginForm(),
      routes: <String, WidgetBuilder>{
        '/homescreen': (context) => Home(),
      },
    );
  }
}
