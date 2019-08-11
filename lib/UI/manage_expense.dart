import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class manage_expense extends StatefulWidget{
  @override
  _manage_expenseState createState()=> _manage_expenseState();
}
class _manage_expenseState extends State<manage_expense>{
  String _selectedLocation,_selectedOperation;
  int _selectedMonth;String _selectedYear;
  var username,token,groupId,email;
  var response_result;
  List<String> _locations = ['A', 'B', 'C', 'D'];
  static List<int> month=[1,2,3,4,5,6,7,8,9,10,11,12];
  static List<String> operation=["Add","Delete"];
  static List<String> year=new List<String>();
  static List<String> cat=new List<String>();
  var response;
  @override
  void initState() {
    // TODO: implement initState
    _retrieveUser();
    super.initState();

  }
  _retrieveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username=prefs.getString('username');
    email=prefs.getString('email');
    token=prefs.getString('token');
    groupId=prefs.getString('groupId');
  }
  void  ret() async {
    Map data = {
      "username":username,
      "email":email,
      "token":token
    };
    year.clear();
    for(var i=2019;i<3000;i++){
      year.add(i.toString());
    }
    response = await http.post("http://192.168.1.162:4000/profile/get-bill-category",headers: {'Content-type': 'application/json'},
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
      "username":username,
      "category":category,
      "groupId":groupId,
      "month":month,
      "year":year,
      "amount":amount,
      "email":email,
      "token":token
    };
    response = await http.post("http://192.168.1.162:4000/profile/add-shared-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    print(response.body);
    response_result=(jsonDecode(response.body));
    setState(() {

    });
    return true;
  }

  Future<bool>  deleteExpense(String category,int month,int year,double amount) async {
    Map data = {
      "username":username,
      "category":category,
      "groupId":groupId,
      "month":month,
      "year":year,
      "amount":amount,
      "email":email,
      "token":token
    };
    response = await http.post("http://192.168.1.162:4000/profile/delete-shared-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    print(response.body);
    response_result=(jsonDecode(response.body));
    setState(() {

    });
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
                  if(response_result!=null){
                    return AlertDialog(
                      content: Text(response_result["data"]['message']),
                      actions: <Widget>[new RaisedButton(child: new Text("OK",style: new TextStyle(color: Colors.white),),onPressed:(){ Navigator.of(context).pop();},color:Colors.teal,)],
                    );
                  }
                  return AlertDialog(
                    content: Text("Done!"),
                    actions: <Widget>[new RaisedButton(child: new Text("OK",style: new TextStyle(color: Colors.white),),onPressed:(){ Navigator.of(context).pop(); },color:Colors.teal)],
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