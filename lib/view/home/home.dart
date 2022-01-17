import 'package:fixtures/view/home/xiaoqiu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my/my.dart';
import 'order.dart';

BuildContext? allContext;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();

}
class _HomePage extends State<HomePage> {

  final tabController = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    allContext = context;
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: SafeArea(
          child: _bottomNavigationBar()),
//        bottomNavigationBar: _bottomNavigationBar()
    );
  }

  // 底部导航界面总体
  Widget _bottomNavigationBar() {
    return CupertinoTabScaffold(
      tabBar: _tabBar(),
      tabBuilder: (context, index) => _tabBuilder(context, index),
      controller: tabController,
    );
  }

  /// 底部导航栏按钮
  CupertinoTabBar _tabBar() {
    return CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "小求"),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted), label: "订单"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
      ],
    );
  }

  /// 底部导航栏路由
  Widget _tabBuilder(context, index) {
    var empty = Container();
    return CupertinoTabView(
      routes: {
        '/home/xiaoqiu': (context) => XiaoqiuPage(),
        '/home/order': (context) => OrderPage(),
        '/home/my': (context) => MyPage(),
      },
      builder: (context) {
        switch (index) {
          case 0:
            return XiaoqiuPage();
          case 1:
            return OrderPage();
          case 2:
            return MyPage();
          default:
            return empty;
        }
      },
    );
  }
}
