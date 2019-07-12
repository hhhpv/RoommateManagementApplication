import 'package:flutter/material.dart';
import 'package:roomate/UI/home.dart';
import 'package:roomate/UI/signup.dart';
import 'package:roomate/UI/login.dart';
import 'package:roomate/UI/join_leave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: new join_leave(),
    );
  }
}
