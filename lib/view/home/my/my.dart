import 'dart:ui';

import 'package:fixtures/config.dart';
import 'package:fixtures/service/api/UserApi.dart';
import 'package:fixtures/utils/utils.dart';
import 'package:fixtures/view/editPersonal/editPersonal.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/home/my/creditCard.dart';
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

class _MyPageState extends State<MyPage> with UserApi {
  static final double gutter = 4;
  int rid = 1;
  String balance = "0.0";
  String age = "0";
  String invitationCode = "000000";
  String nickName = "";
  String phone = "";
  String pic = "";
  String sexStr = "";
  String uName = "";
  String vipStr = "";
  String rolesStr = "";
  double services = 0.0;
  double crafts = 0.0;
  static const int APPBAR_SCROLL_OFFSET = 50;

  double alphaAppBar = 0;

  void getMyInfo() {
    getPersonal(successCallBack: (data) {
      setState(() {
        var user = data["user"];
        var wallet = data["wallet"];
        var master = data["master"];
        services = double.parse(master["services"]);
        crafts = double.parse(master["crafts"]);
        balance = wallet["walletBalance"].toString();
        age = user["age"].toString();
        invitationCode = user["invitationCode"];
        nickName = user["nickName"];
        phone = user["phone"];
        pic = user["pic"];
        sexStr = user["sexStr"];
        uName = user["uName"];
        rid = user["rid"];
        vipStr = user["vipStr"];
        rolesStr = user["rolesStr"];
      });
    }, errorCallBack: (code, msg) {
      print(msg);
    });
  }

  @override
  void initState() {
    getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
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
                              backgroundImage:
                                  NetworkImage(Config.BASE_URL + pic),
                              radius: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                uName,
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
      onTap: () {},
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
            color: taped ? tapedColor : Colors.white,
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: gutter),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(Config.BASE_URL + pic),
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
                              uName,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(gutter),
                            child: Text(
                              age + " 岁",
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
                              "身份：" + rolesStr,
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
    if (rid == 1) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                      _starScoreWidget(5, 20.0, crafts),
                      Text(
                        crafts.toString(),
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
                      _starScoreWidget(5, 20.0, services),
                      Text(
                        services.toString(),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: CupertinoColors.lightBackgroundGray,
                child: CupertinoButton(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    minSize: 0,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(allContext!).push(CupertinoPageRoute(
                        builder: (context) {
                          return BalancePage(balance);
                        },
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              FontAwesomeIcons.wallet,
                              size: 32,
                              color: CupertinoTheme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            "余额",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: CupertinoColors.lightBackgroundGray,
                child: CupertinoButton(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  minSize: 0,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    getMyInfo();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          height: 42,
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            FontAwesomeIcons.idCardAlt,
                            size: 28,
                            color: CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          "会员等级",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        Text(
                          vipStr,
                          style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.inactiveGray),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: gutter),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            children: [
              actionCell(
                  icon: FontAwesomeIcons.shareAlt,
                  title: "邀请二维码",
                  tailing: Icon(
                    CupertinoIcons.forward,
                    size: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return SharePage();
                    }));
                  }),
              Container(
                padding: const EdgeInsets.only(left: 42),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                icon: FontAwesomeIcons.copy,
                title: "我的邀请码",
                tailing: Text(
                  invitationCode,
                  style: TextStyle(color: CupertinoColors.inactiveGray),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return CupertinoPageScaffold(
                      child: Container(),
                    );
                  }));
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 42),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                icon: FontAwesomeIcons.list,
                title: "填写资料",
                tailing: Icon(
                  CupertinoIcons.forward,
                  size: 16,
                  color: CupertinoColors.inactiveGray,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return EditPersonalPage();
                  }));
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 42),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                icon: FontAwesomeIcons.solidCreditCard,
                title: "银行卡",
                tailing: Icon(
                  CupertinoIcons.forward,
                  size: 16,
                  color: CupertinoColors.inactiveGray,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return CreditCardPage();
                  }));
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 42),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                icon: FontAwesomeIcons.cog,
                title: "设置",
                tailing: Icon(
                  CupertinoIcons.forward,
                  size: 16,
                  color: CupertinoColors.inactiveGray,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                    builder: (context) {
                      return SettingPage();
                    },
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
