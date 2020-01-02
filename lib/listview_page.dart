import 'package:flutter/material.dart';

const APPBAR_SCROLL_OFFSET = 100;

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('ListView'),
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            )
        ),
      body:
        Container(
          height: 200,
          child: ListView(
            children: _buildList(),
          )
        )
    );
  }

  List<Widget> _buildList() {
    return ['北京', '上海', '广州', '深圳'].map((city) =>_item(city)).toList();
  }

  Widget _item(city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(city,
        style: TextStyle(color: Colors.white, fontSize: 20),),
    );
  }
}