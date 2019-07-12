import 'package:flutter/material.dart';
class Home extends StatelessWidget{
  var list=["Hitman ","Rocky ","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a"];
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
                    trailing: Icon(Icons.subdirectory_arrow_left)
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