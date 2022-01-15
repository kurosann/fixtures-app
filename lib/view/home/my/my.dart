import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/editPersonal/editPersonal.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/home/my/balance.dart';
import 'package:fixtures/view/setting/setting.dart';
import 'package:fixtures/view/share/share.dart';
import 'package:fixtures/widget/StickyTabBarDelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  String balance = "0.0";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      child: CustomScrollView(slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {},
        ),
        SliverPersistentHeader(
          // 可以吸顶的TabBar
          pinned: true,
          delegate: StickyTabBarDelegate(
            max: 125,
            min: 50,
            pre: _profile(),
            header: Row(
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
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildListDelegate([
//          _role(),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [

                  _score(),
                  _infoGrid(),
                  _actionList(),
                ],
              ),
            ),
          ])),
        )
      ]),
    );
  }

  /// 信息栏
  Widget _profile() {
    return Container(
      height: 125,
      margin: EdgeInsets.symmetric(vertical: gutter),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
            backgroundColor: CupertinoColors.white,
            maxRadius: 40,
            minRadius: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                            fontSize: 12, color: CupertinoColors.inactiveGray),
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
    );
  }

  static final double gutter = 4;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("好评数"),
                  ),
                  _starScoreWidget(5, 20.0, likeScore),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: gutter, vertical: 10),
                    child: Text(likeScore.toString()),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("服务分"),
                  ),
                  _starScoreWidget(5, 20.0, likeScore),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: gutter, vertical: 10),
                    child: Text(likeScore.toString()),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text("友好"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 分数星星组件
  Widget _starScoreWidget(int count, double size, double score) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: RatingBar.builder(
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
          ),
        ),
      ],
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
                      Icons.account_balance_wallet,
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
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
          Divider(
            height: 1.0,
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
          Divider(
            height: 1.0,
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
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
          Divider(
            height: 1.0,
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
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
