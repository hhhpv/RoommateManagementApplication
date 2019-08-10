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
  String _selectedLocation,_selectedOperation;
  int _selectedMonth;String _selectedYear;
  List<String> _locations = ['A', 'B', 'C', 'D'];
  static List<int> month=[1,2,3,4,5,6,7,8,9,10,11,12];
  static List<String> operation=["Add","Delete"];
  static List<String> year=new List<String>();
  static List<String> cat=new List<String>();
  var response;
  void  ret() async {
    Map data = {
      "username":"hit",
      "email":"hit@mail.com",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhpdCIsImVtYWlsIjoiaGl0QG1haWwuY29tIiwiaWF0IjoxNTYyMjM3NzMzLCJleHAiOjE1NjQ4Mjk3MzN9.WJESiaslOqG94RFy-tJ5gz7VRm27UFguzIPOV7Z3mlE"
    };
    year.clear();
    for(var i=2019;i<3000;i++){
      year.add(i.toString());
    }
    response = await http.post("http://192.168.1.2:4000/profile/get-bill-category",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    var r=(jsonDecode(response.body));
    cat.clear();
    for(int i=0;i<r['data']['categories'].length;i++)
      cat.add(r['data']['categories'][i]['category'].toString());
    setState(() {
    });
  }

  Future<bool>  updateExpense(String category,int month,int year,double amount) async {
    Map data = {
      "username":"hit",
      "category":category,
      "groupId":"1",
      "month":month,
      "year":year,
      "amount":amount,
      "email":"hit@mail.com",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhpdCIsImVtYWlsIjoiaGl0QG1haWwuY29tIiwiaWF0IjoxNTYyMjM3NzMzLCJleHAiOjE1NjQ4Mjk3MzN9.WJESiaslOqG94RFy-tJ5gz7VRm27UFguzIPOV7Z3mlE"
    };
    response = await http.post("http://192.168.1.2:4000/profile/add-shared-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    print(response.body);
    return true;
  }

  Future<bool>  deleteExpense(String category,int month,int year,double amount) async {
    Map data = {
      "username":"hit",
      "category":category,
      "groupId":"1",
      "month":month,
      "year":year,
      "amount":amount,
      "email":"hit@mail.com",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhpdCIsImVtYWlsIjoiaGl0QG1haWwuY29tIiwiaWF0IjoxNTYyMjM3NzMzLCJleHAiOjE1NjQ4Mjk3MzN9.WJESiaslOqG94RFy-tJ5gz7VRm27UFguzIPOV7Z3mlE"
    };
    response = await http.post("http://192.168.1.2:4000/profile/delete-shared-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    print(response.body);
    return true;
  }


  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ret();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      amountController.dispose();
      super.dispose();
    }
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Add or Delete Expense",style: new TextStyle(fontFamily: "Ubuntu")),
        backgroundColor: Colors.teal.shade400,
      ),
      backgroundColor: Colors.white,
      body:new ListView(children: <Widget>[
      new Stack(children: <Widget>[
      new Positioned.fill(child: Image.asset('images/dollar.jpg',fit: BoxFit.contain,),),
      new Column(children: <Widget>[
        new Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0)),
        Center(
          child: DropdownButton(
          hint: Text("Select operation",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
          value: _selectedOperation,
          onChanged: (String newValue) {
          setState(() {
          _selectedOperation = newValue;
        });
      },
      items: operation.map((location) {
      return DropdownMenuItem(
      child: new Text(location,style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
      value: location,
          );
        }).toList(),
      ),
      ),

        new Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0))

        ,Center(
          child: DropdownButton(
            hint: Text("Select Expense Category",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
            value: _selectedLocation,
            onChanged: (String newValue) {
              setState(() {
                _selectedLocation = newValue;
                debugPrint(_selectedLocation);
              });
            },
            items: cat.map((location) {
              return DropdownMenuItem(
                child: new Text(location,style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
                value: location,
              );
            }).toList(),
          ),
        ),

        new Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0))
        ,Center(
          child: DropdownButton(
            hint: Text("Select month",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
            value: _selectedMonth,
            onChanged: (int newValue) {
              setState(() {
                _selectedMonth = newValue;
                debugPrint(_selectedLocation);
              });
            },
            items: month.map((location) {
              return DropdownMenuItem(
                child: new Text(location.toString(),style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
                value: location,
              );
            }).toList(),
          ),
        ),

        new Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0))
        ,Center(
          child: DropdownButton(
            hint: Text("Select Year",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
            value: _selectedYear,
            onChanged: (String newYear) {
              setState(() {
                _selectedYear = newYear.trim();
                debugPrint(_selectedYear);
              });
            },
            items: year.map((location) {
              return DropdownMenuItem(
                child: new Text(location,style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
                value: location.trim(),
              );
            }).toList(),
          ),
        ),

        new Padding(padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0)),

        new Column(children: <Widget>[
          new Container(margin: EdgeInsets.fromLTRB(100.0, 0, 100.0, 0),
          child:new TextField(controller: amountController,keyboardType: TextInputType.number,decoration: InputDecoration(
          labelText: "Amount",
          ),)
          )
        ]),


        new Padding(padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0)),
        new Container(
          margin: EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
          child:new RaisedButton(color: Colors.teal.shade200,child: new Text("ADD EXPENSE",style: new TextStyle(fontFamily: "Ubuntu",fontWeight: FontWeight.w900,fontSize: 15),)
            ,onPressed: () {
              debugPrint("this  "+amountController.text);
              if(_selectedOperation=="Add"){updateExpense(_selectedLocation,_selectedMonth, int.parse(_selectedYear),double.parse(amountController.text));
              }else{
                deleteExpense(_selectedLocation,_selectedMonth, int.parse(_selectedYear),double.parse(amountController.text));
              }
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Adding"),
                  );
                },
              );
            },),),
      ],),
      ],)
      ],)
    );
  }
}