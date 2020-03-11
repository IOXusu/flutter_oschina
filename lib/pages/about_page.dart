import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class AboutPage extends StatefulWidget {
  @override
  createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          title: Text(
            '关于',
            style: TextStyle(color: Color(AppColors.APPBAR)),
          )),
    );
  }
}
