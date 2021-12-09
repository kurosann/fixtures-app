import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareState();
}

class _ShareState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          previousPageTitle: '返回',
        ),
        child: Stack(
          children: [
            LimitedBox(
              maxHeight: 2000,
              child: Container(
                color: Colors.grey,
              ),
            ),
            ListView(
              children: [
                LimitedBox(
                  maxHeight: 240,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(100, 100, 100, 100),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: Text("${"小小猪"} 邀请了59个人, 获得现金${11111111}元")),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromARGB(255, 200, 200, 200),
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  child: Column(
                    children: [
                      LimitedBox(
                        maxHeight: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                )
                            ),
                            Text("分享到以下平台"),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                )
                            ),
                          ],
                        ),
                      ),
                      LimitedBox(
                        maxHeight: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.weixin,
                                    size: 40,
                                  ),
                                  Text("微信好友", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.alipay, size: 40),
                                  Text("支付宝好友", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.qrcode, size: 40),
                                  Text(
                                    "二维码",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.copy, size: 40),
                                  Text("复制", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      LimitedBox(
                        maxHeight: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(FontAwesomeIcons.moneyBillAlt)),
                            Text("赚钱攻略", style: TextStyle(fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromARGB(255, 200, 200, 200),
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("我的奖金"),
                        trailing: Text("去提现"),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${521}",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text("元"),
                                  ],
                                ),
                                Text("累计收益"),
                              ],
                            ),
                            SizedBox(height: 40, child: VerticalDivider()),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${2}",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text("元"),
                                  ],
                                ),
                                Text("已邀请"),
                              ],
                            ),
                            SizedBox(height: 40, child: VerticalDivider()),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${1}",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text("人"),
                                  ],
                                ),
                                Text("已陈成功"),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}