import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/findFixture/findFixture.dart';
import 'package:fixtures/view/getWork/getWork.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XiaoqiuPage extends StatelessWidget {
  static XiaoqiuPage? _instance;

  static XiaoqiuPage get instance {
    if (_instance == null) {
      _instance = XiaoqiuPage();
    }
    return _instance!;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(1, 240, 240, 240),
      child: ListView(
        children: [
          _head(),
          Divider(), // 分割线
          _actionButton(),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text("可以帮助您解决一切装修困难"),
          ),
        ],
      ),
    );
  }

  /// 头部部分
  Widget _head() {
    return Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                '小求',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                '你最好的装修帮手',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ));
  }

  /// 按钮部分
  Widget _actionButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
          child: Column(
            children: [
              Icon(
                Icons.search,
                size: 60,
              ),
              Text("找装修")
            ],
          ),
          onPressed: () {
            Navigator.of(allContext!).push(CupertinoPageRoute(builder: (context) {
              return FindFixturePage.instance;
            },));
//            Navigator.pushNamed(allContext!, '/findFixture');
          },
        ),
        CupertinoButton(
          child: Column(
            children: [
              Icon(
                Icons.gavel,
                size: 60,
              ),
              Text("接活")
            ],
          ),
          onPressed: () {
            Navigator.of(allContext!).push(CupertinoPageRoute(builder: (context) {
              return GetWorkPage();
            },));
          },
        )
      ],
    );
  }
}
