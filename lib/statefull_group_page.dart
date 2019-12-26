import 'package:flutter/material.dart';

class StateFullGroup extends StatefulWidget {
  @override
  _StateFullGroupState createState() => _StateFullGroupState();
}

class _StateFullGroupState extends State<StateFullGroup>{
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: '123123123123',
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
        bottomNavigationBar: BottomNavigationBar(
            currentIndex:_currentIndex,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.grey,),
            activeIcon: Icon(Icons.home,color: Colors.blue,),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list,color: Colors.grey,),
            activeIcon: Icon(Icons.list,color: Colors.blue,),
            title: Text('列表')
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0 ? RefreshIndicator(child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.network('http://www.devio.opg/img/avatar.png',
                    width:100,
                    height:100,),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      hintText: '请输入',
                      hintStyle: TextStyle(fontSize: 15)
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top:10),
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                    child: PageView(
                      children: <Widget>[
                        _item('page1',Colors.deepPurple),
                        _item('page2',Colors.green),
                        _item('page3',Colors.red)
                      ],
                    ),
                  ),
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
            )
          ],
        ),onRefresh: _handleRefresh,): Text('列表'),
      ),
    );
  }
  Future<Null> _handleRefresh() async{
      await Future.delayed(Duration(milliseconds: 200));
      return null;
  }
  _item(String title, Color color){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title,style: TextStyle(fontSize: 22,color: Colors.white),),
    );
  }
}