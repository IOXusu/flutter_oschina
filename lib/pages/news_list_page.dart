import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class NewsListPage extends StatefulWidget {
  @override
  createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          title: Text(
        '资讯',
        style: TextStyle(color: Color(AppColors.APPBAR)),
      )),
    );
  }
}
