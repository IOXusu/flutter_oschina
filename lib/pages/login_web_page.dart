import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
