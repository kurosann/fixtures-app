import 'package:fixtures/view/home/my/topUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {

  final double balance;


  BalancePage(this.balance);

  @override
  State<StatefulWidget> createState() => _BalancePageState(balance);
}

class _BalancePageState extends State<BalancePage> {
  double balance;

  _BalancePageState(this.balance);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      navigationBar: CupertinoNavigationBar(
        middle: Text("余额"),
      ),
      child: SafeArea(
        child: Container(
          height: 200,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color.fromARGB(255, 242, 242, 243),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(14),
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
                children: [
                  Text(
                    "$balance",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(10),
                    child: CupertinoButton(
                        color: Colors.grey.shade200,
                        child: Text(
                          "提现",
                          style: TextStyle(color: Colors.black87),
                        ),
                        onPressed: () {}),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(10),
                    child: CupertinoButton.filled(
                        child: Text("充值"),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return TopUpPage(balance);
                            },
                          ));
                        }),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
