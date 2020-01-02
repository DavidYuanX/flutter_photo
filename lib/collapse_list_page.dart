import 'package:flutter/material.dart';

const CITY_NAMES = {
  '北京': [
    '东城区',
    '西城区',
    '朝阳区',
    '丰台区',
    '石景山区',
    '海淀区',
    '顺义区',
  ],
  '上海': [
    '黄浦区',
    '徐汇区',
    '长宁区',
    '静安区',
    '普陀区',
    '闸北区',
    '虹口区',
  ],
  '广州': [
    '越秀',
    '海珠',
    '荔湾',
    '天河',
    '白云',
    '黄埔',
    '南沙',
  ],
  '深圳': [
    '南山',
    '福田',
    '罗湖',
    '盐田',
    '龙岗',
  ],
  '杭州': [
    '上城区',
    '下城区',
    '江干区',
    '拱墅区',
    '西湖区',
    '滨江区',
  ],
  '苏州': [
    '姑苏区',
    '吴中区',
    '相城区',
    '高新区',
    '虎丘区',
    '工业园区',
  ],
};

class CollaoseListPage extends StatefulWidget {
  @override
  _CollaoseListPageState createState() => _CollaoseListPageState();
}

class _CollaoseListPageState extends State<CollaoseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('列表展开与收起'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            )),
        body: Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildList(),
            )));
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_item(key, CITY_NAMES[key]));
    });
//    print(widgets.toString());
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
        title: Text(
          city,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
        children: subCities.map((subcity) => _buildSub(subcity)).toList());
  }

  Widget _buildSub(String sbuCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(sbuCity),
      ),
    );
  }
}

class ExpansionTileSample extends StatefulWidget {
  @override
  _ExpansionTileSampleState createState() => _ExpansionTileSampleState();
}

class _ExpansionTileSampleState extends State<ExpansionTileSample> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('折叠列表'),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) => new EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry('Chapter A',
    <Entry>[
      new Entry('Section A0',
        <Entry>[
          new Entry('Item A0.1'),
          new Entry('Item A0.2'),
          new Entry('Item A0.3'),
        ],
      ),
      new Entry('Section A1'),
      new Entry('Section A2'),
    ],
  ),
  new Entry('Chapter B',
    <Entry>[
      new Entry('Section B0'),
      new Entry('Section B1'),
    ],
  ),
  new Entry('Chapter C',
    <Entry>[
      new Entry('Section C0'),
      new Entry('Section C1'),
      new Entry('Section C2',
        <Entry>[
          new Entry('Item C2.0'),
          new Entry('Item C2.1'),
          new Entry('Item C2.2'),
          new Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return new ListTile(title: new Text(root.title));
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
