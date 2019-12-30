import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 打开第三方应用
class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打开第三方应用'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: ()=> _launchURL(),
              child: Text('打开浏览器'),
            ),
            RaisedButton(
              onPressed: ()=> _openMap(),
              child: Text('打开地图'),
            ),
          ],
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://voyage2030.club';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _openMap() async {
    const url = 'geo:52.32.4.917';
    if(await canLaunch(url)){
      await launch(url);
    } else {
      const url = 'http://maps.apple.com/?ll=52.32,4.917';
      if(await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
