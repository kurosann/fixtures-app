import 'package:fixtures/utils/styles/myStyle.dart';
import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDetailPage extends StatefulWidget {
  static OrderDetailPage? _instance;

  static OrderDetailPage get instance {
    if (_instance == null) {
      _instance = OrderDetailPage();
    }
    return _instance!;
  }

  @override
  State<StatefulWidget> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool _checkboxAliPay = false;
  bool _checkBoxWeiXin = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '订单支付',
        middle: Text("订单支付",style: TextStyle(fontSize: 21.0, color: Colors.black)),
      ),
      backgroundColor: Color.fromARGB(245, 245, 245, 245),
      child: CustomScrollView(slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {},
        ),
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            _profile(),
            _itemCard("价格", "100积分+10元"),
            _itemCard("运费", "10元"),
            _itemCard("优惠", "10元"),
            _totalCard("应付款总额", "￥10元", "(含税费 ￥0.00)"),
            _actionList(),
            _submitOrder()
          ])),
        )
      ]),
    );
  }

  /// 图片和名称信息栏
  Widget _profile() {
    return Container(
      decoration: orderCard(),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Image(
            alignment: Alignment(10, 0),
            image: NetworkImage(
                "https://img2.baidu.com/it/u=2548989639,546384781&fm=15&fmt=auto"),
            width: 70,
            height: 70,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 100,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("扶手楼梯", style: TextStyle(fontSize: 14)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 100,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("某某服务", style: TextStyle(fontSize: 12)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("￥1000 CNY", style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
          Container(
            child: Spacer(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(right: 10),
            decoration: orderCard(),
            child: Text("x${1}"),
          )
        ],
      ),
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
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(title, style: TextStyle(fontSize: 14)),
          ),
          Container(
            child: Spacer(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: Text(end, style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _totalCard(title, total, end) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: EdgeInsets.all(4),
      decoration: orderCard(),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(title, style: TextStyle(fontSize: 14)),
          ),
          Container(
            child: Spacer(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: total,
                          style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
                      TextSpan(
                          text: end,
                          style: TextStyle(fontSize: 8.0, color: Colors.black54)),
                    ])),
          ),
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(4),
      decoration: orderCard(),
      child: Column(
        children: [
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              setState(() {
                _checkboxAliPay = true;
                _checkBoxWeiXin = false;
              });
            },
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.alipay,
                size: 40,
                color: Colors.blue,
              ),
              title: Text("支付宝支付"),
              trailing: new Icon(
                _checkboxAliPay
                    ? FontAwesomeIcons.solidCircle
                    : FontAwesomeIcons.circle,
                color: Colors.deepOrange,
              ),
            ),
          ),
          Divider(
            height: 2.0,
          ),
          TextButton(
            style: mainButtonStyle(),
            onPressed: () {
              setState(() {
                _checkboxAliPay = false;
                _checkBoxWeiXin = true;
              });
            },
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.weixin,
                size: 40,
                color: Colors.green,
              ),
              title: Text("微信支付"),
              trailing: new Icon(
                _checkBoxWeiXin
                    ? FontAwesomeIcons.solidCircle
                    : FontAwesomeIcons.circle,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitOrder() {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
      width: 500,
      child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepOrange,
          child: Text("提交"),
          onPressed: () {}),
    );
  }
}
