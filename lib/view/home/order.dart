import 'package:fixtures/model/Order.dart';
import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/widget/NetServiceFreshPanel.dart';
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
  var orderList = <Order>[];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NetServiceFreshPanel(
        state: NetServiceState.STATE_SUCCESS,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverRefreshControl(
              onRefresh: () async {},
            ),
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text("订单"),
            ),
            SliverSafeArea(
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index.isOdd)
                  return Divider(
                    height: 1,
                  );
                final i = index ~/ 2;
                return orderList.length == 0
                    ? _skeletonItemCell()
                    : _itemCell(i);
              }, childCount: orderList.length == 0 ? 6 : orderList.length * 2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonItemCell() {
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
                  padding: EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 列表子布局
  Widget _itemCell(index) {
    Order order = orderList[index];
    return TextButton(
      style: mainButtonStyle(),
      onPressed: () {
        Navigator.of(allContext!).push(CupertinoPageRoute(
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
                Container(
                  margin: EdgeInsets.all(7),
                  child: Row(
                    children: [Text("工单状态"), Text("000分")],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
