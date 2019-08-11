import 'package:flutter/material.dart';
import 'package:roomate/UI/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roomate/UI/home.dart';

class Home extends StatefulWidget{
  @override
  _HomeForm createState()=> _HomeForm();
}

class _HomeForm extends State<Home>{
  var list=["Hitman ","Rocky ","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a"];
  var username="Person",email="person@mail.com",groupId,token,response,r,result;
  _retrieveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username=prefs.getString('username');
    email=prefs.getString('email');
    token=prefs.getString('token');
    groupId=prefs.getString('groupId');
    _room_mates_list();
    setState(() {
    });
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('token');
    await prefs.remove('groupId');
    await prefs.remove("loggedIn");
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LoginForm()));
  }

  void  _room_mates_list() async {
    Map data = {
      "username":username,
      "email":email,
      "token":token,
      "groupId":groupId
    };
    response = await http.post("http://192.168.1.162:4000/profile/get-room-mates",headers: {'Content-type': 'application/json'}, body: jsonEncode(data));
    r=(jsonDecode(response.body));
    var arr=r['data']['room_mates'];
    list.clear();
    if(arr!=null) {
      for (int i = 0; i < arr.length; i++) {
        list.add(arr[i]['username']);
      }
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    _retrieveUser();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Room-Mate"),
        backgroundColor: Colors.teal.shade400,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.help),
              onPressed: ()=>debugPrint("Help Tapped!"),
              tooltip: "Need Help?"
          )
        ],
        ),
      drawer: Drawer(
          child:new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(accountName: new Text(username), accountEmail: new Text(email),currentAccountPicture: CircleAvatar(backgroundColor:Colors.grey.shade400,child: new Text(username[0],style: new TextStyle(color:Colors.white,fontSize: 50.0),),),decoration: new BoxDecoration(color: Colors.tealAccent.shade700),),
                ListTile(
                  title: Text("Manage Expense"),
                  trailing: Icon(Icons.attach_money),
                ),
                new Divider(color: Colors.black,height: 0,indent: 0,),
                ListTile(
                  title: Text("View Expense"),
                  trailing: Icon(Icons.attach_money),
                ),
                new Divider(color: Colors.black,height: 0,indent: 0,),
                ListTile(
                  title: Text("Join/Leave Group"),
                  trailing: Icon(Icons.group),
                ),
                new Divider(color: Colors.black,height: 0,indent: 0,),
                ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.subdirectory_arrow_left),
                  onTap: ()=>{
                      _logout()
                  },
                ),
                new Divider(color: Colors.black,height: 0,indent: 0,),
                ListTile(
                  title: Text("License"),
                  trailing: Icon(Icons.note),
                ),
                new Divider(color: Colors.black,height: 0,indent: 0,),
              ],
          )
      ),
      backgroundColor: Colors.green.withAlpha(500),
      body:new Stack(children: <Widget>[
        new Positioned.fill(child: Image.asset('images/roomies1.jpeg',fit: BoxFit.fill)),
        new Column(
          children: <Widget>[
            new Card(shape: StadiumBorder(side: BorderSide(width:2.0)),child:InkWell(splashColor:Colors.white.withAlpha(250) ,onTap: ()=>debugPrint("groupId"),child: Text("GroupId: ",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 54.0,fontStyle: FontStyle.italic,fontFamily: "Monotype Corvisa"))),color: Colors.white.withAlpha(150),elevation: 150.0),
            new Card(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),child: Text("Members: ",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 34.0,fontStyle: FontStyle.italic),textAlign: TextAlign.left,),color: Colors.white.withAlpha(150)),
            new Expanded(
              child: new ListView.builder(itemCount:list.length,itemBuilder: (BuildContext context,int index){
                return new Padding(padding: EdgeInsets.all(5.0),child: Card(color:Colors.white.withAlpha(150),shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(7.0)),child: Text("${index+1}. ${list[index]}",style: new TextStyle(fontSize: 24.0),textAlign: TextAlign.left,textScaleFactor: 1.2,))
                    );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true),
            )
          ])
        ])
    );
  }

}