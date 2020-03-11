import 'package:flutter/material.dart';
import 'package:flutter_oschina/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];

  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvarar;
  String userName;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //TODO
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  Container _buildHeader() {
    return Container(
      height: 150.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffffffff),
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/ic_avatar_default.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '点击头像',
              style: TextStyle(color: Color(0xffffffff)),
            )
          ],
        ),
      ),
    );
  }
}
