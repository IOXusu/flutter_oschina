import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _currentIndex = 0;
  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  static const int SHAKE_TIMEOUT = 500;
  static const double SHAKE_THRESHOLD = 3.25;
  var _lastTime = 0;

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      var now = DateTime.now().microsecondsSinceEpoch;
      Vibration.vibrate();
      if ((now - _lastTime) > SHAKE_TIMEOUT) {
        var x = event.x;
        var y = event.y;
        var z = event.z;
        double acce = sqrt(x * x + y * y + z * z) - 9.8;
        if (acce > SHAKE_THRESHOLD) {
          //手机晃动
          Vibration.vibrate();
          _lastTime = now;
          if (mounted) {
            setState(() {
              isShaked = true;
            });
          }
        }
      }

      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '摇一摇',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/shake.png',
              width: 120.0,
              height: 120.0,
            ),
            Text(isShaked ? '活动结束' : '摇一摇获取礼品'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.folder), title: Text('礼品')),
          BottomNavigationBarItem(icon: Icon(Icons.folder), title: Text('资讯'))
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (mounted) {
            setState(() {
              _currentIndex = index;
              isShaked = false;
            });
          }
        },
      ),
    );
  }
}
