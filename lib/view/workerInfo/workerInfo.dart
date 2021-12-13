import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkerInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkerInfoPageState();
}

class _WorkerInfoPageState extends State<WorkerInfoPage> {
  double likeScore = 3.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      child: ListView(
        children: [
          _head(5, 18.0, likeScore),
          _phoneMessage(),
          _describe(),
          _infoGrid(),
        ],
      ),
    );
  }

  Widget _head(int count, double size, double score) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
                radius: 40,
              ),
              UnconstrainedBox(
                alignment: Alignment.center,
                child: Text("xxx人", style: TextStyle(fontSize: 14)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 1, right: 2),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    color: Colors.orangeAccent,
                    child: Text(
                      "深圳",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 1, right: 2),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    color: Color(0xFFFF80AB),
                    child: Text("20岁",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.crown,
                          size: 20,
                        ),
                        Text(
                          "工程次数：${6}次",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  "服务分：${9.2}分",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  "彼此距离：${200}m",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _phoneMessage() {
    double padding = 12;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: (){},
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.phone,
                      size: 30,
                      color: Colors.green,
                    ),
                    Text("打电话")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {  },
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(Icons.mail, size: 30, color: Colors.orange),
                    Text("发信息"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _infoGrid() {
    double padding = 8;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {  },
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidAddressCard,
                      size: 30,
                      color: Colors.green,
                    ),
                    Text("实名认证")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {  },
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.video, size: 30, color: Colors.orange),
                    Text("人脸识别"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _describe() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text("个人简介", style: TextStyle(fontSize: 14),),
          Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 150,
              minWidth: double.infinity,
            ),
            child: Container(
              child: Text(
                "。。。"
              ),
            ),
          ),
        ],
      ),
    );
  }
}
