import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  createState() => PublishTweetPageState();
}

class PublishTweetPageState extends State<PublishTweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        title: Text(
          '发布动弹',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
      ),
    );
  }
}
