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
        appBar: AppBar(
            title: Text('StatelessWidget与基础组件'),
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            )
        ),
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
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network('http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                            width:100,
                            height:100,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          child: Opacity(
                            opacity: 0.6,
                            child: Image.network('http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                              width:100,
                              height:100,),
                          ),
                        ),
                      ),
                      Image.network('http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                        width:100,
                        height:100,),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      hintText: '请输入',
                      hintStyle: TextStyle(fontSize: 15)
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
//                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                    child: PhysicalModel(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        clipBehavior: Clip.antiAlias,
                        child: PageView(
                          children: <Widget>[
                            _item('page1',Colors.deepPurple),
                            _item('page2',Colors.green),
                            _item('page3',Colors.red)
                          ],
                        ),
                    )
                  ),
                  Column(
                    children: <Widget>[
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.greenAccent),
                          child: Text('宽度撑满'),
                        ),
                      )
                    ],
                  ),
//                  Text('I an Text',
//                    style: textStyle,),
//                  Icon(Icons.android,size: 50,color: Colors.red,),
//                  CloseButton(),
//                  BackButton(),
//                  Chip(
//                    avatar: Icon(Icons.people),
//                    label: Text('1231231231'),
//                  ),
//                  Divider(
//                    height: 10,
//                    indent: 10,
//                    color: Colors.orange,
//                  ),
//                  Card(
//                    color: Colors.blue,
//                    elevation: 5,
//                    margin: EdgeInsets.all(10),
//                    child: Container(
//                      padding: EdgeInsets.all(10),
//                      child: Text(
//                        'I an Card',
//                        style: textStyle,
//                      ),
//                    ),
//                  ),
//                  AlertDialog(
//                    title: Text('panta'),
//                    content: Text('adasdsa'),
//                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Image.network('http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                  width:100,
                  height:100,),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Image.network('http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                    width:36,
                    height:36,),
                )
              ],
            ),
            Wrap(
              spacing: 8, // 横向间距
              runSpacing: 6, // 垂直间距
              children: <Widget>[
                _chip('Flutter'),
                _chip('Flutter1'),
                _chip('Flutter2'),
                _chip('Flutter3'),
                _chip('Flutter4'),
                _chip('Flutter5'),
                _chip('Flutter6'),
              ],
            )
          ],
        ),onRefresh: _handleRefresh,)
        : Column(
          children: <Widget>[
            Text('列表'),
            Expanded(
              child:  Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('列表列表列表'),
              ),
            )
          ],
        ),
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

  _chip(String label) {
    return Chip(label: Text(label),
      avatar: CircleAvatar(
       backgroundColor: Colors.blue.shade900,
          child: Text(
            label.substring(0,1),
            style: TextStyle(fontSize: 10),
          ),
      ),);
  }
}