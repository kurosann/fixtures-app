import 'package:fixtures/utils/styles/myStyle.dart';
import 'package:fixtures/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDetailPage extends StatefulWidget {
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
        previousPageTitle: '返回',
        middle: Text("订单支付"),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {},
        ),
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            _profile(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding: EdgeInsets.all(4),
                decoration: orderCard(),
                child: Column(children: [
                  _itemCard("价格", "100积分+10元"),
                  Divider(height: 1,),
                  _itemCard("运费", "10元"),
                  Divider(height: 1,),
                  _itemCard("优惠", "10元"),
                  Divider(height: 1,),
                  _totalCard("应付款总额", "￥${10}元", "(含税费 ￥${0.00})"),
                ])),
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
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 70,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: Image(
              image: NetworkImage(
                  "https://img2.baidu.com/it/u=2548989639,546384781&fm=15&fmt=auto"),
              width: 70,
              height: 70,
            ),
          ),
          Container(
            height: double.maxFinite,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Container(
                      child: Text("扶手楼梯", style: TextStyle(fontSize: 14))),
                ),
                Container(
                  child: Text("某某服务",
                      style: TextStyle(
                          fontSize: 10, color: CupertinoColors.inactiveGray)),
                ),
              ],
            ),
          ),
          Container(
            child: Spacer(),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: double.maxFinite,
            decoration: orderCard(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin:EdgeInsets.symmetric(vertical: 2),
                  child: Text("￥1000元", style: TextStyle(fontSize: 12)),
                ),
                Text("x${1}", style: TextStyle(fontSize: 10,color: CupertinoColors.inactiveGray)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _itemCard(title, end) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 8),
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
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(title, style: TextStyle(fontSize: 14)),
          ),
          Container(
            child: Spacer(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
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
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.all(8),
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
              selected: _checkboxAliPay,
              selectedColor: aliPayActive,
              minLeadingWidth: 10,
              leading: Icon(
                FontAwesomeIcons.alipay,
                color: aliPayColor,
              ),
              title: Text("支付宝支付"),
              trailing: Icon(
                _checkboxAliPay
                    ? FontAwesomeIcons.solidCircle
                    : FontAwesomeIcons.circle,
                size:16,
                color: aliPayColor,
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
              autofocus: true,
              minLeadingWidth: 10,
              selected: _checkBoxWeiXin,
              selectedColor: weixinSelectColor,
              leading: Icon(
                FontAwesomeIcons.weixin,
                color: weixinColor,
              ),
              title: Text("微信支付"),
              trailing: new Icon(
                _checkBoxWeiXin
                    ? FontAwesomeIcons.solidCircle
                    : FontAwesomeIcons.circle,
                size:16,
                color: weixinColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color aliPayColor = CupertinoColors.systemBlue;
  Color aliPayActive = CupertinoColors.activeBlue;

  Color weixinColor = CupertinoColors.systemGreen;
  Color weixinSelectColor = CupertinoColors.activeGreen;

  Widget _submitOrder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: CupertinoButton(
          padding: EdgeInsets.symmetric(vertical: 8),
          borderRadius: BorderRadius.circular(12),
          color: CupertinoTheme.of(context).primaryColor,
          child: Text("提交"),
          onPressed: () {}),
    );
  }
}
