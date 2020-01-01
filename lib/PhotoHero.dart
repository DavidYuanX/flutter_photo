import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

import 'package:flutter_photo/photo_app_page.dart';

class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme
          .of(context)
          .primaryColor
          .withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: Image.network(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
//    return SizedBox(
//      width: width,
//      child: Hero(
//        tag: photo,
//        child: Material(
//          color: Colors.transparent,
//          child: InkWell(
//            onTap: onTap,
//            child: Image.network(
//              photo,
//              fit: BoxFit.contain,
//            ),
//          ),
//        ),
//      ),
//    );
  }
}

class RadiaExpansion extends StatelessWidget {
  RadiaExpansion({
    Key key,
    this.maxRadius,
    this.child,
  }) : cliRectSize = 2.0 * (maxRadius / math.sqrt2);
  final double maxRadius;
  final cliRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: cliRectSize,
          height: cliRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadiaExpansionDemo extends StatelessWidget {
  static const double KMinRadius = 32.0;
  static const double KMaxRadius = 128.0;
  static const opacityCurve =
  const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName,
      String description) {
    return Container(
      color: Theme
          .of(context)
          .canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: KMaxRadius * 2,
                height: KMaxRadius * 2,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadiaExpansion(
                    maxRadius: KMaxRadius,
                    child: PhotoHero(
                        photo: imageName,
                        onTap: () {
                          Navigator.of(context).pop();
                        }
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, String imageName,
      String description) {
    return Container(
      width: KMinRadius * 2,
      height: KMinRadius * 2,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadiaExpansion(maxRadius: KMaxRadius, child: PhotoHero(
          photo: imageName,
          onTap: () {
            Navigator.of(context).push(
                PageRouteBuilder<void>(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Opacity(opacity:
                            opacityCurve.transform(animation.value),
                            child: _buildPage(context, imageName, description),
                          );
                        },
                      );
                    }
                )
            );
          },
        ),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    timeDilation = 10.0;  /// 改变全局动画速度
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(context, 'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773', 'Avatar'),
//            _buildHero(context, 'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773', '2'),
//            _buildHero(context, 'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773', '3'),
//            _buildHero(context, 'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773', '4'),
//            _buildHero(context, 'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773', '5'),
          ],
        )
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    timeDilation = 10.0;  /// 改变全局动画速度
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animarion'),
      ),
      body: Center(
        child: PhotoHero(
          photo:
          'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Basic Hero Animarion'),
                ),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo:
                    'http://static.sunlands.com/user_center/newUserImagePath/4656924/4656924.jpg?dc=1577441350773',
                    width: 100,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
