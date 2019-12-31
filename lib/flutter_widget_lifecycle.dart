

import 'package:flutter/material.dart';

/// Flutter Widget 的生命周期重点讲解StatefulWidget的生命周期
/// 因为无状态的widget Statelesswidget只有createElemement、与build两个生命周期方法
/// 1，初始化时期
/// createState、initState
/// 2，更新期间
/// didChangeDependencies、build、didUpdateWidget
/// 3，销毁期
/// deactivate、dispose

class WidgetLifecycle extends StatefulWidget {
  /// 新建 StatefulWidget 这个会立即调用
  @override
  _WidgetLifecycleState createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  int _count = 0;
  /// Widget 创建时 调用的 初构造方法外的第一个方法，做一些初始化的工作。
  @override
  void initState() {
    // TODO: implement initState
    print('----initState----');
    super.initState();
  }

  /// 当所依赖的State对象改变时会调用：
  /// a.在第一次构建widget 时，在initState（）之后立即调用此方法；
  /// b.如果StatefullWidgets 依赖于InheritedWidget，那么当当前State所依赖InheritedWidgets中的变量 改变时会再次调用它
  /// 拓展：InheritedWidget 可以高效的将数据在Widget树中向下传递、共享，可参考: https://book.flutterchina.club/chapter7/inherited_widget.html
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('----didChangeDependencies----');
    super.didChangeDependencies();
  }
  /// 这是一个必须实现的方法，在这里实现你要呈现的页面内容；
  /// 它会在 在didChangeDependencies（）之后立即调用；
  /// 另外当调用setState后也会再次调用该方法；
  @override
  Widget build(BuildContext context) {
    print('----build----');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 页面生命周期'),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                setState(() {
                  _count+=1;
                });
              },
              child: Text('点我',style: TextStyle(fontSize: 26),),
            ),
            Text(_count.toString())
          ],
        ),
      ),
    );
  }

  /// 这是一个不常用到的生命周期方法，当父组件需要重新绘制时才会调用；
  /// 该方法会携带一个oldWidget参数，可以将其与当前的widget进行比对以便执行一些额外的逻辑，
  /// 如 if(oldWidget.xxx != widget.xxx) ....
  @override
  void didUpdateWidget(WidgetLifecycle oldWidget) {
    print('----didUpdateWidget----');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('-----deactivate-----');
    super.deactivate();
  }


  /// 常用，组件被销毁时调用；
  /// 通常在该方法中执行一些资源的释放工作比如，监听器的卸载，channel的销毁等
  @override
  void dispose() {
    print('----dispose----');
    super.dispose();
  }


}
