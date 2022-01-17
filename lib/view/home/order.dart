import 'package:fixtures/model/Order.dart';
import 'package:fixtures/service/base/HttpManager.dart';
import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/handlingOrder/handlingOrder.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/widget/NetServiceFreshPanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {

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
        onNetData: () async {
          Result result = Result();
          return result;
        },
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
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Divider(
                      height: 1,
                    ),
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
        Navigator.of(allContext!).push(CupertinoPageRoute(
          builder: (context) {
            return HandlingOrderPage(
              id: "1",
            );
          },
        ));
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 140,
                      height: 12,
                      decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 140,
                      height: 12,
                      decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: 100,
              height: 12,
              decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(4)),
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
        height: 50,
        margin: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右对齐
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text("工程编号："),
                    Text("000000000"),
                  ],
                ),
                Row(
                  children: [
                    Text("开始时间："),
                    Text("000000000"),
                  ],
                )
              ],
            ),
            Container(
              child: Text("工单状态${'000分'}"),
            )
          ],
        ),
      ),
    );
  }
}
