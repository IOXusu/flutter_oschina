import 'package:flutter/material.dart';
import 'package:flutter_oschina/common/event_bus.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/utils/data_util.dart';

class SettingsPage extends StatefulWidget {
  @override
  createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        title: Text(
          '设置',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              DataUtils.clearLoginInfo().then((_) {
                eventBus.fire(LogOutEvent());
                Navigator.of(context).pop();
              });
            },
            child: Text(
              '退出登录',
              style: TextStyle(fontSize: 20.0),
            )),
      ),
    );
  }
}
