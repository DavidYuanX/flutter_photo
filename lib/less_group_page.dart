import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';


class LessGroupPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: '12321321',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('StatelessWidget与基础组件')),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('I an Text',
              style: textStyle,),
              Icon(Icons.android,size: 50,color: Colors.red,),
              CloseButton(),
              BackButton(),
              Chip(
                avatar: Icon(Icons.people),
                label: Text('1231231231'),
              ),
              Divider(
                height: 10,
                indent: 10,
                color: Colors.orange,
              ),
              Card(
                color: Colors.blue,
                elevation: 5,
                margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'I an Card',
                      style: textStyle,
                    ),
                  ),
              ),
              AlertDialog(
                title: Text('panta'),
                content: Text('adasdsa'),
              )
            ],
          ),
        ),
      ),
    );
  }
}