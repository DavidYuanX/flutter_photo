import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  List _imageUrls = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577892165738&di=d3b12c26a39d44dd0ce6536ec04c4abe&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fef6043c0f407dac052c3b53b533274e30feb8b3e810f-dzocHu_fw658',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577892165738&di=d3b12c26a39d44dd0ce6536ec04c4abe&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fef6043c0f407dac052c3b53b533274e30feb8b3e810f-dzocHu_fw658',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577892165738&di=d3b12c26a39d44dd0ce6536ec04c4abe&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fef6043c0f407dac052c3b53b533274e30feb8b3e810f-dzocHu_fw658',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577892165738&di=d3b12c26a39d44dd0ce6536ec04c4abe&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fef6043c0f407dac052c3b53b533274e30feb8b3e810f-dzocHu_fw658',
  ];
  double appBarAlpha = 0;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  String showResult = '';
  String countString = '';
  String localCount = '';

  Future<CommonModel> fetchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8decoder = Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Http请求'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          )
      ),
        body:
//        Container(
//          height: 200,
//          child: ListView(
//            children: _buildList(),
//          ),
//        )
      Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            fetchPost().then((CommonModel value) {
                              setState(() {
                                showResult =
                                '请求结果：\nhideAppBar: ${value
                                    .hideAppBar}\nicon: ${value.icon}';
                              });
                            });
                          },
                          child: Text(
                            '点我',
                            style: TextStyle(fontSize: 26),
                          )),
                      Text(showResult),
                      FutureBuilder<CommonModel>(
                          future: fetchPost(),
                          builder: (BuildContext context,
                              AsyncSnapshot<CommonModel> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text('Input a Url to start');
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              case ConnectionState.active:
                                return new Text('');
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return new Text(
                                    '${snapshot.error}',
                                    style: TextStyle(color: Colors.red),
                                  );
                                } else {
                                  return new Column(
                                    children: <Widget>[
                                      Text('icon:${snapshot.data.icon}'),
                                      Text(
                                          'statusBarColor:${snapshot.data.statusBarColor}'),
                                      Text('title:${snapshot.data.title}'),
                                      Text('url:${snapshot.data.url}'),
                                    ],
                                  );
                                }
                            }
                          }),
                      RaisedButton(
                        onPressed: _incrementCounter,
                        child: Text('Increment Count'),
                      ),
                      RaisedButton(
                        onPressed: _getCounter,
                        child: Text('Get Count'),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            countString,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            localCount,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ))),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
    setState(() {
      countString = prefs.getInt('counter').toString();
    });
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = ' Count: ' + prefs.getInt('counter').toString();
    });
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

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }
}
