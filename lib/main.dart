import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_photo/Animate_page.dart';
import 'package:flutter_photo/PhotoHero.dart';
import 'package:flutter_photo/app_lifecycle.dart';
import 'package:flutter_photo/collapse_list_page.dart';
import 'package:flutter_photo/flutter_widget_lifecycle.dart';
import 'package:flutter_photo/gesture_page.dart';
import 'package:flutter_photo/gridView_page.dart';
import 'package:flutter_photo/http_page.dart';
import 'package:flutter_photo/launcher_page.dart';
import 'package:flutter_photo/less_group_page.dart';
import 'package:flutter_photo/listview_page.dart';
import 'package:flutter_photo/photo_app_page.dart';
import 'package:flutter_photo/plugin_use.dart';
import 'package:flutter_photo/res_page.dart';
import 'package:flutter_photo/statefull_group_page.dart';

void main() => runApp(DynamicTheme());

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
//        fontFamily: 'RubikMonoOne',  /// 全局改变字体
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('如何使用路由导航'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  if (_brightness == Brightness.dark) {
                    _brightness = Brightness.light;
                  } else {
                    _brightness = Brightness.dark;
                  }
                });
              },
              child: Text(
                '切换主题abc',
                style: TextStyle(fontFamily: 'RubikMonoOne'),
              ),

              /// 局部改变字体
            ),
            RouteNavigatorState()
          ],
        ),
      ),
      routes: <String, WidgetBuilder>{
        'Less': (BuildContext context) => LessGroupPage(),
        'Plugin': (BuildContext context) => PluginUse(),
        'Full': (BuildContext context) => StateFullGroup(),
        'Gesture': (BuildContext context) => GesturePage(),
        'ResPage': (BuildContext context) => ResPage(),
        'LaunchPage': (BuildContext context) => LaunchPage(),
        'WidgetLifecycle': (BuildContext context) => WidgetLifecycle(),
        'AppLifecycle': (BuildContext context) => AppLifecycle(),
        'Photo': (BuildContext context) => PhotoPage(),
        'LogoAnimateApp': (BuildContext context) => LogoAnimateApp(),
        'HeroAnimation': (BuildContext context) => RadiaExpansionDemo(),
        'HttpPage': (BuildContext context) => HttpPage(),
        'ListView': (BuildContext context) => ListViewPage(),
        'ExpansionTileSample': (BuildContext context) => ExpansionTileSample(),
        'GridViewPage': (BuildContext context) => GridViewPage(),
      },
    );
  }
}

// RouteNavigator
class RouteNavigatorState extends StatefulWidget {
  @override
  _RouteNavigatorStateState createState() => _RouteNavigatorStateState();
}

class _RouteNavigatorStateState extends State<RouteNavigatorState> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 8, // 横向间距
        runSpacing: 6, // 垂直间距
        children: <Widget>[
          SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            },
          ),
          _item('包和插件', PluginUse(), 'Plugin'),
          _item('lessWidget与基础组件', LessGroupPage(), 'Less'),
          _item('fullWidget与基础组件', StateFullGroup(), 'Full'),
          _item('检测用户手势及处理点击时间', GesturePage(), 'Gesture'),
          _item('导入使用Flutter的资源文件', ResPage(), 'ResPage'),
          _item('打开第三方应用', LaunchPage(), 'LaunchPage'),
          _item('Flutter页面生命周期', WidgetLifecycle(), 'WidgetLifecycle'),
          _item('Flutter应用生命周期', AppLifecycle(), 'AppLifecycle'),
          _item('拍照and相册', PhotoPage(), 'Photo'),
          _item('Flutter动画', LogoAnimateApp(), 'LogoAnimateApp'),
          _item('FlutterHero动画', RadiaExpansionDemo(), 'HeroAnimation'),
          _item('HttpPage请求', HttpPage(), 'HttpPage'),
          _item('ListView列表', ListViewPage(), 'ListView'),
          _item('折叠列表', ExpansionTileSample(), 'ExpansionTileSample'),
          _item('网格布局', GridViewPage(), 'GridViewPage'),

        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('如何使用路由导航'),
//        ),
//        body: RouteNavigatorState(),
//      ),
//      routes: <String,WidgetBuilder>{
//        'Less':(BuildContext context)=>LessGroupPage(),
//        'Plugin':(BuildContext context)=>PluginUse(),
//        'Full':(BuildContext context)=>StateFullGroup(),
//        'Gesture':(BuildContext context)=>GesturePage(),
//        'ResPage':(BuildContext context)=>ResPage(),
//        'LaunchPage':(BuildContext context)=>LaunchPage(),
//        'WidgetLifecycle':(BuildContext context)=>WidgetLifecycle(),
//        'AppLifecycle':(BuildContext context)=>AppLifecycle(),
//
//      },
//    );
//  }
//}
