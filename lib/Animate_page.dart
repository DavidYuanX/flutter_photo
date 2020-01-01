import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo({Key key, Animation<double> animation})
  : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      )
    );
  }
}

class LogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child,this.animation});

  final Widget child;
  final Animation <double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context,child)=> Container(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}


class LogoAnimateApp extends StatefulWidget {
  @override
  _LogoAnimateAppState createState() => _LogoAnimateAppState();
}

class _LogoAnimateAppState extends State<LogoAnimateApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        setState(() {
          animationStatus = state;
        });
      }); /// 手动监听
      controller.forward(); /// 自动开始
  }

  @override
  void dispose() { /// 注意资源 及时回收
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter动画'),
        leading: BackButton(),
      ),
//    body: new AnimatedLogo(animation: animation); /// 使用AnimatedWidget
//    body: GrowTransition(animation: animation,child: LogWidget(),) /// 使用AnimatedBuilder
      body: Container(
        margin: EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        child:  GrowTransition(animation: animation,child: LogWidget(),), /// 使用AnimatedBuilder
//        child:  new AnimatedLogo(animation: animation) /// 使用AnimatedWidget
//        child: Column( /// 使用手动监听的方法
//          children: <Widget>[
//            GestureDetector(
//              onTap: () {
//                controller.reset();
//                controller.forward();
//              },
//              child: Text(
//                'Start',
//                textDirection: TextDirection.ltr,
//              ),
//            ),
//            Text('State:' + animationStatus.toString(),textDirection: TextDirection.ltr,),
//            Text('Value:' + animationValue.toString(),textDirection: TextDirection.ltr,),
//            Container(
//              height: animation.value,
//              width: animation.value,
//              child: FlutterLogo(),
//            )
//          ],
//        ),
      )
    );
  }
}
