import 'package:flutter/material.dart';
import 'package:roomate/UI/home.dart';
import 'package:roomate/UI/signup.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: new SignUpForm(),
    );
  }
}
