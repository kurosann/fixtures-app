import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home.dart';

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
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        children: [
//          _role(),
          _profile(),
          _score(),
          _infoGrid(),
          _actionList(),
        ],
      ),
    );
  }

  /// 信息栏
  Widget _profile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
            radius: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  child: Text("xxx人"),
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text("身份："),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text("某某身份"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.all(10),
                child: Text("00岁"),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(10),
                child: Text("某某服务"),
              ),
            ],
          )
        ],
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
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 200, 200, 200),
                blurRadius: 1.0,
                spreadRadius: 1.0)
          ],
          border: Border.all(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 1,
            style: BorderStyle.solid,
          )),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("好评数"),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("服务分"),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  _starScoreWidget(5, 20.0, likeScore),
                  _starScoreWidget(5, 20.0, serveScore),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Text(likeScore.toString()),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Text(serveScore.toString()),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromARGB(255, 200, 200, 200),
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 1,
            style: BorderStyle.solid,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 60,
                color: Colors.grey,
              ),
              Text("钱包"),
              Text("000\$")
            ],
          ),
          Column(
            children: [
              Icon(Icons.person_pin, size: 60, color: Colors.grey),
              Text("会员等级"),
              Text("黄金会员")
            ],
          )
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 1,
            style: BorderStyle.solid,
          )),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("我的会员"),
            subtitle: Text("黄金会员"),
            trailing: Text("去升级"),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("余额提现"),
            trailing: Text("提现"),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("邀请二维码"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.record_voice_over),
            title: Text("我的邀请码"),
            trailing: Text("336402"),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("填写资料"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.pushNamed(allContext!, "/setting");
            },
          ),
        ],
      ),
    );
  }
}
