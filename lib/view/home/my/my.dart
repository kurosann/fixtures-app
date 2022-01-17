import 'dart:ui';

import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/editPersonal/editPersonal.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/home/my/balance.dart';
import 'package:fixtures/view/setting/setting.dart';
import 'package:fixtures/view/share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyPage extends StatefulWidget {
  static MyPage? _instance;

  static MyPage get instance {
    if (_instance == null) {
      _instance = MyPage();
    }
    return _instance!;
  }

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  static final double gutter = 4;

  String balance = "0.0";

  static const int APPBAR_SCROLL_OFFSET = 50;

  double alphaAppBar = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        child: Stack(
          children: [
            NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  var offset = notification.metrics.pixels;
                  double alpha = (offset / APPBAR_SCROLL_OFFSET)
                      .clamp(0, 1); // APPBAE_SCROLL_OFFSET为appBar高度
                  setState(() {
                    alphaAppBar = alpha;
                  });
                }
                return true;
              },
              child: CustomScrollView(slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {},
                ),
                SliverSafeArea(
                    sliver: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      var offset = notification.metrics.pixels;
                      double alpha = offset /
                          APPBAR_SCROLL_OFFSET; // APPBAE_SCROLL_OFFSET为appBar高度
                      if (alpha < 0) {
                        alpha = 0;
                      } else if (alpha > 1) {
                        alpha = 1;
                      }
                      setState(() {
                        alphaAppBar = alpha;
                      });
                    }
                    return false;
                  },
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _profile(),
                          _score(),
                          _infoGrid(),
                          _actionList(),
                        ],
                      ),
                    ),
                  ])),
                ))
              ]),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: ClipRect(
                child: Opacity(
                  opacity: alphaAppBar > 0.1 ? 1 : 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Opacity(
                      opacity: alphaAppBar,
                      child: Container(
                        height: APPBAR_SCROLL_OFFSET.toDouble(),
                        color: CupertinoColors.white.withAlpha(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
                              radius: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "xxx人",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  /// 信息栏
  Widget _profile() {
    Color tapedColor = CupertinoColors.white.withAlpha(100);
    bool taped = false;
    return GestureDetector(
      onTap: () {
      },
      onTapDown: (e) {
        setState(() {
          taped = true;
        });
      },
      onTapUp: (e) {
        setState(() {
          taped = false;
        });
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: taped?tapedColor:Colors.white, borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: gutter),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
                  backgroundColor: CupertinoColors.white,
                  minRadius: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "xxx人",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(gutter),
                            child: Text(
                              "00岁",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CupertinoColors.inactiveGray),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "身份：${'某某身份'}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "服务：${'某某服务'}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.forward,
                size: 18,
                color: CupertinoColors.inactiveGray,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 分数栏
  Widget _score() {
    var likeScore = 3.0;
    var serveScore = 3.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
//          boxShadow: [
//            BoxShadow(
//                color: Color.fromARGB(255, 200, 200, 200),
//                blurRadius: 1.0,
//                spreadRadius: 1.0)
//          ],
//          border: Border.all(
//            color: Color.fromARGB(255, 200, 200, 200),
//            width: 1,
//            style: BorderStyle.solid,
//          )
      ),
      margin: EdgeInsets.symmetric(vertical: gutter),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "好评数",
                        style: TextStyle(fontSize: 14),
                      ),
                      _starScoreWidget(5, 20.0, likeScore),
                      Text(
                        likeScore.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "服务分",
                        style: TextStyle(fontSize: 14),
                      ),
                      _starScoreWidget(5, 20.0, likeScore),
                      Text(
                        likeScore.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 240, 240, 240),
//                    border: Border.all(
//                      color: Color.fromARGB(255, 240, 240, 240),
//                      width: 1,
//                      style: BorderStyle.solid,
//                    )
              ),
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "友好",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 分数星星组件
  Widget _starScoreWidget(int count, double size, double score) {
    return RatingBar.builder(
      itemCount: count,
      allowHalfRating: true,
      ignoreGestures: true,
      itemSize: size,
      initialRating: score,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (value) {},
    );
  }

  Widget _infoGrid() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: gutter),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
//          border: Border.all(
//            color: Color.fromARGB(255, 200, 200, 200),
//            width: 1,
//            style: BorderStyle.solid,
//          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(allContext!).push(CupertinoPageRoute(
                      builder: (context) {
                        return BalancePage(balance);
                      },
                    ));
                  },
                  style: mainButtonStyle(),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.wallet,
                        size: 40,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                      Text("余额"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Hero(
                              tag: 'balance',
                              child: Text(
                                balance,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.inactiveGray),
                              )),
                          Text(
                            "￥",
                            style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.inactiveGray),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.person_pin,
                    size: 40,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                  Text("会员等级"),
                  Text(
                    "黄金会员",
                    style: TextStyle(
                        fontSize: 12, color: CupertinoColors.inactiveGray),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: gutter),
      padding: EdgeInsets.all(gutter),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
//          border: Border.all(
//            color: Color.fromARGB(255, 200, 200, 200),
//            width: 1,
//            style: BorderStyle.solid,
//          )
      ),
      child: Column(
        children: [
//          TextButton(
//            style: mainButtonStyle(),
//            onPressed: () {
//              Navigator.of(allContext!)
//                  .push(CupertinoPageRoute(builder: (BuildContext context) {
//                return CupertinoPageScaffold(
//                  child: Container(),
//                );
//              }));
//            },
//            child: ListTile(
//              leading: Icon(Icons.person),
//              title: Text("我的会员"),
//              subtitle: Text("黄金会员"),
//              trailing: Text("去升级"),
//            ),
//          ),
//          Divider(
//            height: 1.0,
//          ),
//          TextButton(
//            style: mainButtonStyle(),
//            onPressed: () {
//              Navigator.of(allContext!)
//                  .push(CupertinoPageRoute(builder: (BuildContext context) {
//                return CupertinoPageScaffold(
//                  child: Container(),
//                );
//              }));
//            },
//            child: ListTile(
//              leading: Icon(Icons.file_upload),
//              title: Text("余额提现"),
//              trailing: Text("提现"),
//            ),
//          ),
//          Divider(
//            height: 1.0,
//          ),
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              Navigator.of(allContext!)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return SharePage();
              }));
            },
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text("邀请二维码"),
              trailing: Icon(
                CupertinoIcons.forward,
                size: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Divider(
              height: 1.0,
            ),
          ),
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              Navigator.of(allContext!)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
            child: ListTile(
              leading: Icon(Icons.record_voice_over),
              title: Text("我的邀请码"),
              trailing: Text("336402"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Divider(
              height: 1.0,
            ),
          ),
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              Navigator.of(allContext!)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return EditPersonalPage();
              }));
            },
            child: ListTile(
              leading: Icon(Icons.description),
              title: Text("填写资料"),
              trailing: Icon(
                CupertinoIcons.forward,
                size: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Divider(
              height: 1.0,
            ),
          ),
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              Navigator.of(allContext!).push(CupertinoPageRoute(
                builder: (context) {
                  return SettingPage();
                },
              ));
            },
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("设置"),
              trailing: Icon(
                CupertinoIcons.forward,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
