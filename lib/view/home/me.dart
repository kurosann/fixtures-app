import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MePageState();
}

class MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          _role(),
          _profile(),
          _score(),
        ],
      ),
    );
  }

  Widget _role() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("我的身份:"),
        ),
        Container(
          width: 100,
          padding: EdgeInsets.all(10),
          child: Text("某某身份"),
        ),
      ],
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
          Column(
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("xxx人"),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("某某服务"),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.all(10),
                child: Text("00岁"),
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
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 200, 200, 200),blurRadius: 1.0, spreadRadius: 1.0)
          ],
          border: Border.all(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 1,
            style: BorderStyle.solid,
          )
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    )
                ),
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                child: Text("友好"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 分数组件
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
}
