import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        title: Text(
          '设置',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
      ),
    );
  }
}
