import 'package:flutter/material.dart';

/*
The following class has been added for a feature that demonstrates the future scope of the application
*/

class join_leave extends StatefulWidget {
  _join_leaveState createState() => _join_leaveState();
}

class _join_leaveState extends State<join_leave> {
  TextEditingController _textController = TextEditingController();

  final List<String> _listViewData = ["1","2","3"];

  List<String> _newData = [];

  _onChanged(String value) {
    setState(() {
      _newData = _listViewData
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Group',style: new TextStyle(fontFamily: "Ubuntu"),),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'enter group id',
              ),
              onChanged: _onChanged,
              onTap: ()=>debugPrint(_textController.text),
            ),
          ),
          SizedBox(height: 20.0),
          _newData != null && _newData.length != 0
              ? Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: _newData.map((data) {
                return ListTile(title: Text(data),onTap: ()=>debugPrint(data),);
              }).toList(),
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}