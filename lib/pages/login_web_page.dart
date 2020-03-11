import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/utils/data_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../constants/constants.dart';
import '../constants/constants.dart';
import '../constants/constants.dart';
import '../constants/constants.dart';
import '../constants/constants.dart';
import '../constants/constants.dart';
import '../utils/net_util.dart';

class LoginWebPage extends StatefulWidget {
  @override
  createState() => LoginWebPageState();
}

class LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      print('onUrlChanged:$url');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (url != null && url.length > 0 && url.contains('?code=')) {
        String code = url.split('?')[1].split('&')[0].split('=')[1];
        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
          print('$data');
          if (data != null) {
            Map<String, dynamic> map = json.decode(data);
            if (map != null && map.isNotEmpty) {
              DataUtils.saveLoginInfo(map);
              Navigator.pop(context, 'refresh');
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(color: Color(AppColors.APPBAR)),
      ),
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id' +
          AppInfos.CLIENT_ID +
          '&redirect_url=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        title: Row(
          children: children(),
        ),
      ),
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    );
  }

  List<Widget> children() {
    return <Widget>[
      Text(
        '登录开源中国',
        style: TextStyle(color: Color(AppColors.APPBAR)),
      ),
      CupertinoActivityIndicator(),
    ];
  }
}
