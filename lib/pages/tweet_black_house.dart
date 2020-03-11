import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class TweetBlackHousePage extends StatefulWidget {
  @override
  createState() => TweetBlackHouseState();
}

class TweetBlackHouseState extends State<TweetBlackHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        title: Text(
          '动弹小黑屋',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
      ),
    );
  }
}
