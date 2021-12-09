import 'package:fixtures/model/Order.dart';
import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../handlingOrder/handlingOrder.dart';

class OrderPage extends StatefulWidget {
  static OrderPage? _instance;

  static OrderPage get instance {
    if (_instance == null) {
      _instance = OrderPage();
    }
    return _instance!;
  }

  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  /// 订单数据
  var orderList = <Order>[Order(),Order(),Order(),];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {

            },
          ),
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text("订单"),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            if (index.isOdd)
              return Divider(
                height: 1,
              );
            final i = index ~/ 2;
            return _itemCell(i);
          }, childCount: orderList.length * 2)),
        ],
      ),
    );
  }

  /// 列表子布局
  Widget _itemCell(index) {
    return TextButton(
      style: mainButtonStyle(),
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) {
            return HandlingOrderPage(
              id: "1",
            );
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text("工程编号："),
                      Text("000000000"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text("开始时间："),
                      Text("000000000"),
                    ],
                  ),
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
      ),
    );
  }
}
