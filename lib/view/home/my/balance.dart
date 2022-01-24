import 'package:fixtures/view/home/my/topUp.dart';
import 'package:fixtures/view/home/my/withdraw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  final String balance;

  BalancePage(this.balance);

  @override
  State<StatefulWidget> createState() => _BalancePageState(balance);
}

class _BalancePageState extends State<BalancePage> {
  String balance;

  _BalancePageState(this.balance);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text("余额")
      ),
      child: SafeArea(
        child: ListView(children: [
          Container(
            height: 340,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "可用余额(元)",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Hero(
                      tag: 'balance',
                      child: Text(
                        balance,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text("￥"),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  height: 140,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'TopUp',
                        child: CupertinoButton.filled(
                            child: Text("充值"),
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => TopUpPage(balance),
                              ));
                            }),
                      ),
                      Expanded(child: Container()),
                      Hero(
                        tag: 'Withdraw',
                        child: CupertinoButton(
                            color: Colors.grey.shade200,
                            child: Text(
                              "提现",
                              style: TextStyle(color: Colors.black87),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => WithdrawPage(balance),
                              ));
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
