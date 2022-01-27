import 'dart:async';

import 'package:fixtures/model/Order.dart';
import 'package:fixtures/service/api/LoginApi.dart';
import 'package:fixtures/service/base/HttpManager.dart';
import 'package:fixtures/view/handlingOrder/handlingOrder.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/widget/NetServiceFreshPanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with LoginMixin {
  /// 订单数据
  var orderList = <Order>[];

  var freshState = NetServiceState.PROCESS;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverSafeArea(
                sliver: freshState == NetServiceState.SUCCESS
                    ? CupertinoSliverRefreshControl(
                        onRefresh: () async {
                          Result result = Result();
                          await Future.delayed(Duration(seconds: 3));
                          result.code = 200;
                          setState(() {
                            orderList = [
                              Order(),
                            ];
                          });
                        },
                      )
                    : SliverToBoxAdapter(),
              ),
              CupertinoSliverNavigationBar(
                backgroundColor: CupertinoColors.systemGroupedBackground,
                border: Border.all(color: CupertinoColors.white.withAlpha(0)),
                largeTitle: Text("订单"),
              ),
              SliverToBoxAdapter(
                child: NetServiceFreshPanel(
                  state: freshState,
                  loadingPanel: Container(
                    color: Colors.white,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        for (int i = 0; i < 10; i += 1) _skeletonItemCell()
                      ],
                    ),
                  ),
                  onRequest: () async {
                    Result result = Result();
                    await Future.delayed(Duration(seconds: 3));
                    setState(() {
                      orderList = [
                        Order(),
                        Order(),
                      ];
                      freshState = NetServiceState.SUCCESS;
                    });
                    result.code = 200;
                    return result;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderList.length * 2,
                    itemBuilder: (context, index) {
                      if (index.isOdd)
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Divider(
                            height: 1,
                          ),
                        );
                      final i = index ~/ 2;
                      return _itemCell(i);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skeletonItemCell() {
    return Container(
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
                        color: CupertinoColors.systemGroupedBackground,
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
                        color: CupertinoColors.systemGroupedBackground,
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
                color: CupertinoColors.systemGroupedBackground,
                borderRadius: BorderRadius.circular(4)),
          )
        ],
      ),
    );
  }

  /// 列表子布局
  Widget _itemCell(index) {
    Order order = orderList[index];
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: CupertinoButton(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        padding: EdgeInsets.all(8),
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
                      Text(
                        "工程编号：",
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.black),
                      ),
                      Text(
                        "000000000",
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "开始时间：",
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.black),
                      ),
                      Text(
                        "000000000",
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.black),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  child: Text(
                "工单状态${'000分'}",
                style: TextStyle(fontSize: 14, color: CupertinoColors.black),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
