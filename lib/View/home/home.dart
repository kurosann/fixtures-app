import 'package:fixtures/View/home/xiaoqiu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: XiaoqiuPage(),
      bottomNavigationBar: _bottomNavigationBar()
    );
  }

  Widget _bottomNavigationBar() {
    return CupertinoTabScaffold(
      tabBar: _tabBar(),
      tabBuilder: (context, index) => _tabBuilder(context, index),
      controller: CupertinoTabController(
        initialIndex: 0,
      ),
    );
  }
  Widget _tabBar() {
    return CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("小求")),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted), title: Text("订单")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
      ],
    );
  }

  Widget _tabBuilder(context, index) {
    return CupertinoTabView(
      routes: {
        '/xiaoqiu': (context) => XiaoqiuPage(),
        '/order': (context) => OrderPage(),
        '/me': (context) => XiaoqiuPage(),
      },
      builder: (context) {
        switch (index) {
          case 0:
            return XiaoqiuPage();
          case 1:
            return OrderPage();
          case 2:
            return XiaoqiuPage();
          default:
            return Container();
        }
      },
    );
  }
}

