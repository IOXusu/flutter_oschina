import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xffaaaaaa), width: 1.0))),
        child: Column(
          children: <Widget>[
            Text(''),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Text(''),
                Row(
                  children: <Widget>[
                    Icon(Icons.message),
                    Text(''),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
