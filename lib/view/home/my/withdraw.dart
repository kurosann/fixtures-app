import 'dart:async';

import 'package:fixtures/utils/styles/myStyle.dart';
import 'package:fixtures/view/login/loginStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawPage extends StatefulWidget {
  final String balance;

  WithdrawPage(this.balance);

  @override
  State<StatefulWidget> createState() => _WithdrawPageState(balance);
}

class _WithdrawPageState extends State<WithdrawPage> {
  String balance;
  late Timer _timer;
  int _countdownTime = 0;
  var way = 0;
  final phoneCode = TextEditingController();
  var _controller = TextEditingController();

  _WithdrawPageState(this.balance);

  @override
  Widget build(BuildContext context) {
    var rulesTile = Container(
        padding: EdgeInsets.only(top: 40),
        child: Row(children: <Widget>[
          Expanded(
            child: Divider(height: 1,color:Colors.grey),
          ),
          Expanded(
              child: Text(
            '提现须知',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
                color: Colors.orange,),

            textAlign: TextAlign.center,
          )),
          Expanded(
            child: Divider(height: 1,color:Colors.grey),
          ),
        ]));
    // color: Color.fromARGB(255, 250, 130, 65)),
    var rulesBody = Container(
        padding: EdgeInsets.only(top: 20,left: 30),
        child: Row(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Text(
                '1.仅支持账户全额提现，实际到账金额以当日结算为准。\n'+
                '2.申请审核通过后，抵用券自动作废。\n'+
                '3.提现将扣除相应的充值优惠。\n'+
                '4.工作日星期二至星期五可作为提现时间 \n',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                )
              )),
        ]));

    /// 用户手机短信验证码输入框
    var codeSms = Container(
      padding: EdgeInsets.only(top: 24),
      child: CupertinoTextField(
        controller: phoneCode,
        placeholderStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Color.fromARGB(255, 93, 93, 93)),
        decoration: WithdrawTextFieldBoxStyle(),
        padding: EdgeInsets.symmetric(vertical: 14),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.digitsOnly
        ],
        prefix: Text(
          '验证码: ',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        placeholder: ' 已发送您的手机,请查收 ',
        clearButtonMode: OverlayVisibilityMode.editing,
        keyboardType: TextInputType.number,
      ),
    );

    void openMsg(String msg) {
      showCupertinoDialog(
          context: context,
          builder: (c) {
            return CupertinoAlertDialog(
              title: Text('短信验证'),
              content: codeSms,
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('确认'),
                  onPressed: () {
                    Navigator.of(context).pop("ok");
                  },
                ),
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop("ok");
                  },
                ),
              ],
            );
          });
    }

    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          middle: Text("提现"),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "提现方式",
                        style: TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showPopupModel(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: way == 0
                                  ? Icon(
                                      FontAwesomeIcons.weixin,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.alipay,
                                      color: Colors.blue,
                                    ),
                            ),
                            Text(
                              way == 0 ? "微信" : "支付宝",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: way == 0 ? Colors.green : Colors.blue),
                            ),
                            Icon(
                              CupertinoIcons.forward,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromARGB(255, 242, 242, 243),
                    width: 0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Text(
                            "提现金额",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CupertinoTextField(
                        clearButtonMode: OverlayVisibilityMode.editing,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        autofocus: true,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "￥",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        decoration: BoxDecoration(),
                        style: TextStyle(fontSize: 34),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "账户余额：",
                            style: TextStyle(fontSize: 14),
                          ),
                          Hero(
                            tag: 'balance',
                            child: Text(
                              balance,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            "￥",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Hero(
                  tag: 'Withdraw',
                  child: CupertinoButton.filled(
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          Text("提现"),
                          Expanded(child: Container()),
                        ],
                      ),
                      onPressed: () {
                        openMsg("");
                      }),
                ),
              ),
              rulesTile,
              rulesBody,
            ],
          ),
        ));
  }

  void _showPopupModel(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  way = 0;
                });
                Navigator.of(context).pop();
              },
              child: Text("微信", style: TextStyle(color: Colors.green)),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  way = 1;
                });
                Navigator.of(context).pop();
              },
              child: Text("支付宝", style: TextStyle(color: Colors.blue)),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("取消"),
          ),
        );
      },
    );
  }

//  void toAlipay() async {
//    tobias.isAliPayInstalled().then((value) => { // 判断是否安装了支付宝
//      if (!value) {
//        showAlert('请安装支付宝')
//      }else{
//        // @TODO 需等待后端订单接口
//        tobias.aliPay(result['data']['body']).then((payRes) {
//          if (payRes['resultStatus'] == 9000 ||
//              payRes['resultStatus'] == '9000') {
//            orderDealAfterOk(result['data']['orderId']);
//          } else {
//            showAlert(payRes['memo']);
//          }
//        })
//      }
//    });
//  }

  void showAlert(title) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          actions: [CupertinoDialogAction(child: Text("确定"))],
        );
      },
    );
  }
}
