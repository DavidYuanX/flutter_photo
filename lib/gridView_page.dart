import 'package:flutter/material.dart';

const CITY_NAMES = [
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

class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('网格列表'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            )),
        body: GridView.count(
            crossAxisCount: 3, /// 显示列数
            children: _buildList()));
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
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
