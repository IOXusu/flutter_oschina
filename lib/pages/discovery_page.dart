import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          title: Text(
            '发现',
            style: TextStyle(color: Color(AppColors.APPBAR)),
          )),
    );
  }
}
