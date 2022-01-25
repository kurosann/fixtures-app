import 'package:fixtures/utils/styles/myStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CostNeedPage extends StatefulWidget {
  static CostNeedPage? _instance;

  static CostNeedPage get instance {
    if (_instance == null) {
      _instance = CostNeedPage();
    }
    return _instance!;
  }

  @override
  State<StatefulWidget> createState() => _CostNeedPageState();
}

class _CostNeedPageState extends State<CostNeedPage> {
  final divider = Divider(height: 1, indent: 20);
  final rightIcon = Icon(Icons.keyboard_arrow_right);
  final navTitle = ["10mm玻璃：27元", "不锈钢扶手：27元", "其他：27元"];
  void _showInfoDialog(context, String content) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: '费用需求',
            middle: Text("费用需求",style: TextStyle(fontSize: 21.0, color: Colors.black)),
          ),
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: CupertinoSliverRefreshControl(
                  onRefresh: () async {},
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _msgCard("${'陈师傅'}", "手艺分数：", "${9.9}"),
                    _actionList(),
                    _itemCard("标的价格：", "${60}元"),
                    _itemCard("补贴：", "${60}元"),
                    _itemCard("标的价格：", "标的价格-标的价格*0.2"),
                    _costShow(),
                    _submitOrder()
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(4),
      decoration: orderCard(),
      child: Column(
          children: navTitle
              .map((item, {index}) => Container(
                    margin:EdgeInsets.only(left: 20),
                    child:
                        Row(children: [new Text(item), Divider()]),
                    alignment: Alignment.center,
                  ))
              .toList()),
    );
  }

  Widget _itemCard(title, end) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: EdgeInsets.all(4),
      decoration: orderCard(),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
            padding: EdgeInsets.only(left: 10),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text(end, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _msgCard(title, msg, total) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: EdgeInsets.all(4),
      decoration: orderCard(),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: msg,
                  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16, color: Colors.black)),
              TextSpan(
                  text: total,
                  style: TextStyle(fontSize: 18.0, color: Colors.orange)),
            ])),
          ),
        ],
      ),
    );
  }
  Widget _submitOrder() {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 20),
      width: 500,
      child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepOrange,
          child: Text("付费"),
          onPressed: () {}),
    );
  }

  /// 费用说明
  Widget _costShow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
              padding: EdgeInsets.all(10),
              child: Text(
                '联系师傅',
                style: TextStyle(fontSize: 18,color: Colors.blue,),
              ),
              onPressed: () {
                _showInfoDialog(context, '联系师傅');
              }),
          Spacer(),
          Row(
            children: [
              CupertinoButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '费用说明',
                    style: TextStyle(fontSize: 18,color: Colors.blue,),
                  ),
                  onPressed: () {
                    _showInfoDialog(context, '费用说明');
                  })
            ],
          ),
        ],
      ),
    );
  }

}
