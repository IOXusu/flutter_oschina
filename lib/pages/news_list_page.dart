import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina/common/event_bus.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/pages/login_web_page.dart';
import 'package:flutter_oschina/utils/data_util.dart';
import 'package:flutter_oschina/utils/net_util.dart';
import 'package:flutter_oschina/widget/news_list_item.dart';

class NewsListPage extends StatefulWidget {
  @override
  createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;
  List newsList;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getNewsList(true);
      }
    });
    DataUtils.isLogin().then((isLogin) {
      if (mounted) {
        setState(() {
          isLogin = isLogin;
        });
      }
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (mounted) {
        setState(() {
          isLogin = true;
        });
        getNewsList(false);
      }
    });
    eventBus.on<LogOutEvent>().listen((event) {
      if (mounted) {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('请先登录...'),
            RaisedButton(
              child: Text('去登录'),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  eventBus.fire(LoginEvent());
                }
              },
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () {
        _pullToRefresh;
      },
      child: buildListView(),
    );
  }

  Widget buildListView() {
    if (newsList == null) {
      getNewsList(false);
      return CupertinoActivityIndicator();
    }

    return ListView.builder(
        controller: _controller,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsListItem(
            newsList: newsList[index],
          );
        });
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  void getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((token) {
          if (token == null || token.length == 0) {
            return;
          }
          Map<String, dynamic> params = new Map<String, dynamic>();
          params['access_token'] = token;
          params['catalog'] = 1;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
//            {
//              "newslist": [{
//                  "author": "oschina",
//                  "id": 114221,
//                  "title": "劫掠轩辕剑 —— 使用 C++ 重新实现经典的 RPG 游戏",
//                  "type": 1,
//                  "authorid": 1,
//                  "pubDate": "2020-03-20 08:19:00",
//                  "object": 50505,
//                  "commentCount": 0
//                  }, {
//                  "author": "oschina",
//                  "id": 114220,
//                  "title": "RISC-V 基金会总部已正式迁移至瑞士",
//                  "type": 4,
//                  "authorid": 1,
//                  "pubDate": "2020-03-20 08:14:33",
//                  "commentCount": 4
//                  }]
//            }
            print('NEWS_LIST:$data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _newsList = map['newslist'];
              if (mounted) {
                setState(() {
                  if (isLoadMore) {
                    newsList.addAll(_newsList);
                  } else {
                    newsList = _newsList;
                  }
                });
              }
            }
          });
        });
      }
    });
  }
}
