import 'package:flutter/material.dart';
class Home extends StatelessWidget{
  var list=["a","b"];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Room-Mate"),
        backgroundColor: Colors.teal.shade400,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.help),
              onPressed: ()=>debugPrint("help tapped"),
              tooltip: "Need Help?"
          )
        ],
        ),
      drawer: Drawer(
          child:new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(accountName: new Text("Person"), accountEmail: new Text("person@mail.com"),currentAccountPicture: CircleAvatar(backgroundColor:Colors.grey.shade400,child: new Text("P",style: new TextStyle(color:Colors.white,fontSize: 50.0),),),decoration: new BoxDecoration(color: Colors.tealAccent.shade700),),
                ListTile(
                  title: Text("Manage Expense"),
                  trailing: Icon(Icons.attach_money),
                ),
                ListTile(
                  title: Text("View Expense"),
                  trailing: Icon(Icons.attach_money),
                ),
                ListTile(
                  title: Text("Logout"),
                  trailing: Icon(Icons.subdirectory_arrow_left)
                ),
                ListTile(
                  title: Text("License"),
                  trailing: Icon(Icons.note),
                )
              ],
          )
      ),
      backgroundColor: Colors.grey.shade200,
      body: new Center(
      child:new Column(
        children: <Widget>[
          new Card(child: Text("GroupId: ",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 54.0,fontStyle: FontStyle.italic,fontFamily: "Monotype Corvisa")),color: Colors.grey.shade200),
          new Card(child: Text("Members: ",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 34.0,fontStyle: FontStyle.italic),textAlign: TextAlign.left,),color: Colors.grey.shade200),
          new ListView.builder(itemCount:list.length,itemBuilder: (BuildContext context,int index){
            return new Card(child: Text("${index+1}. ${list[index]}",style: new TextStyle(fontSize: 24.0),));
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,)
          ],
        )
      )
    );
  }

}