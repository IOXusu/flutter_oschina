import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/utils/data_util.dart';
import 'package:flutter_oschina/utils/net_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;

  const NewsDetailPage({Key key, this.id})
      : assert(id != null),
        super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;
  String url;

  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } else if (state.type == WebViewState.startLoad) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
    DataUtils.getAccessToken().then((token) {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['access_token'] = token;
      params['id'] = widget.id;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.NEWS_DETAIL, params).then((data) {
        print('NEWS_LIST:$data');
        if (data != null && data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          if (mounted) {
            setState(() {
              url = map['url'];
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '资讯详情',
        style: TextStyle(
          color: Color(AppColors.APPBAR),
        ),
      )
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    return url == null
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : WebviewScaffold(
            url: url,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
              title: Row(
                children: _appBarTitle,
              ),
            ),
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          );
  }
}
