import 'package:fixtures/model/Order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  static OrderPage _instance;

  static OrderPage get instance {
    if (_instance == null) {
      _instance = OrderPage();
    }
    return _instance;
  }
  @override
  State<StatefulWidget> createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  /// 订单数据
  var orderList = <Order>[Order()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: Text("订单"),
            )
          ];
        },
        body: ListView.builder(
          itemCount: orderList.length * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;

            return _itemCell();
          },
        ),
      ),
    );
  }

  /// 列表子布局
  Widget _itemCell() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("工程编号："),
                    Text("000000000"),
                  ],
                ),
              ),
              Row(
                children: [
                  Text("开始时间："),
                  Text("000000000"),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text("工单状态"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text("000分"),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
