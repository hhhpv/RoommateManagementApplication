import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map expenses={};
class view_expense extends StatefulWidget{
  @override
  _view_expenseState createState()=> _view_expenseState();
}
class _view_expenseState extends State<view_expense>{
  Future<Map>  retrieveExpense(int month,int year) async {
    Map data = {
      "username":"hit",
      "groupId":"1",
      "month":month,
      "year":year,
      "email":"hit@mail.com",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhpdCIsImVtYWlsIjoiaGl0QG1haWwuY29tIiwiaWF0IjoxNTYyMjM3NzMzLCJleHAiOjE1NjQ4Mjk3MzN9.WJESiaslOqG94RFy-tJ5gz7VRm27UFguzIPOV7Z3mlE"
    };
    var response = await http.post("http://192.168.1.2:4000/profile/view/monthly-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    var result=jsonDecode(response.body);
    if(result['result']!="failure") {
      for (int i = 0; i < result['data'].length; i++) {
        expenses[result['data'][i]['category']] =
        result['data'][i]['amount']["\$numberDecimal"];
      }
    }
    if(expenses.length==0){
      expenses["No records found"]="Try Later";
    }
    expenses.forEach((k,v)=>
      print('${k} : ${v}')
    );
    print(expenses.length);
    setState(() {});
    return expenses;
  }
  @override
  void initState() {
    super.initState();
    retrieveExpense(1, 2019);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Expense Report",style: new TextStyle(fontFamily: "Ubuntu")),backgroundColor: Colors.teal.shade400),
      body: new Center(
        child:new ListView.builder(itemCount: expenses.length,itemBuilder:(BuildContext context,int index){
    String key = expenses.keys.elementAt(index);
    return new Column(
    children: <Widget>[
        new ListTile(
        title: new Text("$key"),
        subtitle: new Text("${expenses[key]}"),
        ),
        new Divider(
        height: 2.0,
        ),
        ],
        );
        },
        ))
      );
    }
}