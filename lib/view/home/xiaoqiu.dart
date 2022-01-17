import 'dart:ui';

import 'package:fixtures/view/findFixture/findFixture.dart';
import 'package:fixtures/view/getWork/getWork.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XiaoqiuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _XiaoqiuPage();
}

class _XiaoqiuPage extends State<XiaoqiuPage> {
  double alphaAppBar = 0;

  static const int APPBAR_SCROLL_OFFSET = 50;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/ss.png",
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollNotification) {
                  var offset = notification.metrics.pixels;
                  double alpha =
                      (offset / APPBAR_SCROLL_OFFSET).clamp(0, 1);
                  setState(() {
                    alphaAppBar = alpha;
                  });
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverSafeArea(
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      _head(),
                      Divider(), // 分割线
                      _actionButton(),
                      Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child: Text("可以帮助您解决一切装修困难"),
                      ),
                    ])),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: Opacity(
                opacity: alphaAppBar>0.1?1:0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Opacity(
                    opacity: alphaAppBar,
                    child: Container(
                      height: APPBAR_SCROLL_OFFSET.toDouble(),
                      color: CupertinoColors.white.withAlpha(100),
                      child: _head(),
                    ),
                  ),
                ),
              ),
            ),
          )
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
              Hero(tag: "找装修", child: Text("找装修"))
            ],
          ),
          onPressed: () {
            Navigator.of(allContext!).push(CupertinoPageRoute(
              builder: (context) {
                return FindFixturePage.instance;
              },
            ));
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
            Navigator.of(allContext!).push(CupertinoPageRoute(
              builder: (context) {
                return GetWorkPage();
              },
            ));
          },
        )
      ],
    );
  }
}
