import 'package:flutter/material.dart';
import 'package:flutter_oschina/common/event_bus.dart';
import 'package:flutter_oschina/constants/constants.dart';
import 'package:flutter_oschina/utils/data_util.dart';
import 'package:flutter_oschina/widget/news_list_item.dart';

class NewsListPage extends StatefulWidget {
  @override
  createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;

  @override
  void initState() {
    super.initState();
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
        getNewList();
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
    return RefreshIndicator(
      onRefresh: () {},
      child: ListView.builder(itemBuilder: (context, index) {
        return NewsListItem();
      }),
    );
  }

  getNewList() async {
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
        });
      }
    });
  }
}
