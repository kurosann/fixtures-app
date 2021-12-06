import 'dart:ui';

import 'package:fixtures/View/home/me.dart';
import 'package:fixtures/View/home/xiaoqiu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body: _bottomNavigationBar(),
//        bottomNavigationBar: _bottomNavigationBar()
       );
  }

  // 底部导航界面总体
  Widget _bottomNavigationBar() {
    return CupertinoTabScaffold(
      tabBar: _tabBar(),
      tabBuilder: (context, index) => _tabBuilder(context, index),
      controller: CupertinoTabController(
        initialIndex: 0,
      ),
    );
  }

  /// 底部导航栏按钮
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

  /// 底部导航栏路由
  Widget _tabBuilder(context, index) {
    return CupertinoTabView(
      routes: {
        '/xiaoqiu': (context) => XiaoqiuPage(),
        '/order': (context) => OrderPage(),
        '/me': (context) => MePage(),
      },
      builder: (context) {
        switch (index) {
          case 0:
            return XiaoqiuPage();
          case 1:
            return OrderPage();
          case 2:
            return MePage();
          default:
            return Container();
        }
      },
    );
  }
}
