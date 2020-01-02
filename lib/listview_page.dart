import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<String> CITY_NAMES = [
    '东城区',
    '西城区',
    '朝阳区',
    '丰台区',
    '石景山区',
    '海淀区',
    '顺义区',
    '黄浦区',
    '徐汇区',
    '长宁区',
    '静安区',
    '普陀区',
    '闸北区',
    '虹口区',
    '越秀',
    '海珠',
    '荔湾',
    '天河',
    '白云',
    '黄埔',
    '南沙',
    '上城区',
    '下城区',
    '江干区',
    '拱墅区',
    '西湖区',
    '滨江区',
    '姑苏区',
    '吴中区',
    '相城区',
    '高新区',
    '虎丘区',
    '工业园区'
  ];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(CITY_NAMES);
      list.addAll(CITY_NAMES);
      CITY_NAMES = list;
    });
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      CITY_NAMES = CITY_NAMES.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('ListView'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            )),
        body: Container(
//          height: 200,
            child: RefreshIndicator(
          child: ListView(
            controller: _scrollController,
//            scrollDirection: Axis.horizontal, /// 横向滚动
            children: _buildList(),
          ),
          onRefresh: _handleRefresh,
        )));
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
