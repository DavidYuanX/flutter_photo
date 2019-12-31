

import 'package:flutter/material.dart';

/// 如何获取Flutter应用纬度生命周期
/// WidgetsBindingObserver：是一个Widgets绑定观察器，通过它我们可以监听应用的生命周期。

class AppLifecycle extends StatefulWidget {
  @override
  _AppLifecycleState createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver{
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter应用 生命周期'),
        leading: BackButton(),
      ),
      body: Container(
        child: Text('Flutter应用生命周期'),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state=$state');
    if(state==AppLifecycleState.paused){
      print('App进入后台');
    } else if (state == AppLifecycleState.resumed){
      print('App进入前台');
    } else if (state == AppLifecycleState.inactive){
      print('App处于非活动状态');
      // 不常用： 应用程序处于非活动状态，并且未接受用户输入时调用，比如：来电话
    }
//    else if (state == AppLifecycleState.suspending){
//      // 不常用：应用程序挂起时调用，不会在ios上触发
//    }
  }

  @override
  void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
  }
}
