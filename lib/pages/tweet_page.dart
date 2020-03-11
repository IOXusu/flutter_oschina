import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class TweetPage extends StatefulWidget {
  @override
  createState() => TweetPageState();
}

class TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          title: Text(
            '动弹',
            style: TextStyle(color: Color(AppColors.APPBAR)),
          )),
    );
  }
}
