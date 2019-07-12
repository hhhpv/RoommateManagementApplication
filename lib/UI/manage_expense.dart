import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class manage_expense extends StatefulWidget{
  @override
  _manage_expenseState createState()=> _manage_expenseState();
}
class _manage_expenseState extends State<manage_expense>{
  String _selectedLocation;
  List<String> _locations = ['A', 'B', 'C', 'D'];
  static List<String> cat=new List<String>();
  var response;
  void  ret() async {
    Map data = {
      "username":"hit",
      "email":"hit@mail.com",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhpdCIsImVtYWlsIjoiaGl0QG1haWwuY29tIiwiaWF0IjoxNTYyMjM3NzMzLCJleHAiOjE1NjQ4Mjk3MzN9.WJESiaslOqG94RFy-tJ5gz7VRm27UFguzIPOV7Z3mlE"
    };
    response = await http.post("http://10.0.2.2:4000/profile/get-bill-category",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    var r=(jsonDecode(response.body));
    cat.clear();
    for(int i=0;i<r['data']['categories'].length;i++)
      cat.add(r['data']['categories'][i]['category'].toString());
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    ret();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add or Delete Expense",style: new TextStyle(fontFamily: "Ubuntu")),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Center(
        child: DropdownButton(
          hint: Text("Select Expense Category"), // Not necessary for Option 1
          value: _selectedLocation,
          onChanged: (String newValue) {
            setState(() {
              _selectedLocation = newValue;
              debugPrint(_selectedLocation);
            });
          },
          items: cat.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }
}