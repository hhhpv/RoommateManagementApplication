import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Map expenses={};
class view_expense extends StatefulWidget{
  @override
  _view_expenseState createState()=> _view_expenseState();
}
class _view_expenseState extends State<view_expense>{
  var username,email,token,groupId;
  static List<int> month=[1,2,3,4,5,6,7,8,9,10,11,12];
  static List<String> year=new List<String>();
  int _selectedmonth;String _selectedyear;
  @override
  void initState() {
    // TODO: implement initState
    year.clear();
    for(var i=2019;i<3000;i++){
      year.add(i.toString());
    }
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

  Future<Map>  retrieveExpense(int month,int year) async {
    debugPrint(token);
    Map data = {
      "username":username,
      "groupId":groupId,
      "month":month,
      "year":year,
      "email":email,
      "token":token
    };
    var response = await http.post("http://192.168.1.162:4000/profile/view/monthly-expense",headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    var result=jsonDecode(response.body);
    debugPrint(result.toString());
    expenses.clear();
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text("Expense Report",style: new TextStyle(fontFamily: "Ubuntu")),backgroundColor: Colors.teal.shade400),
      body:
      new Column(children: <Widget>[

      DropdownButton(
      hint: Text("Select Month",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
      value: _selectedmonth,
      onChanged: (int newValue) {
        setState(() {
          _selectedmonth = newValue;
        });
      },
      items: month.map((location) {
        return DropdownMenuItem(
          child: new Text(location.toString(),style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
          value: location,
        );
      }).toList(),
    ),


    DropdownButton(
    hint: Text("Select Year",style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),), // Not necessary for Option 1
    value: _selectedyear,
    onChanged: (String newValue) {
    setState(() {
    _selectedyear = newValue;
    });
    },
    items: year.map((location) {
    return DropdownMenuItem(
    child: new Text(location,style: new TextStyle(color: Colors.teal,fontFamily: "Ubuntu",fontSize: 20.0),),
    value: location,
    );
    }).toList(),
    ),

        new RaisedButton(color: Colors.teal.shade200,child: new Text("RETRIEVE",style: new TextStyle(fontFamily: "Ubuntu",fontWeight: FontWeight.w900,fontSize: 15),)
          ,onPressed: () {
            retrieveExpense(_selectedmonth, int.parse(_selectedyear));
          },)

    ,new Center(
        child:new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: expenses.length,itemBuilder:(BuildContext context,int index){
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
      ],)
    );

    }
}