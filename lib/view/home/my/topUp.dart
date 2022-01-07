import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopUpPage extends StatefulWidget {
  final double balance;

  TopUpPage(this.balance);

  @override
  State<StatefulWidget> createState() => _TopUpPageState(balance);
}

class _TopUpPageState extends State<TopUpPage> {
  double balance;

  var way = 0;

  var _controller = TextEditingController();

  _TopUpPageState(this.balance);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
        navigationBar: CupertinoNavigationBar(
          middle: Text("充值"),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "充值方式",
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
                            "充值金额",
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
                        children: [
                          Text(
                            "账户余额:$balance",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: CupertinoButton.filled(
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Text("充值"),
                        Expanded(child: Container()),
                      ],
                    ),
                    onPressed: () {}),
              )
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
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        actions: [
          CupertinoDialogAction(child: Text("确定"))
        ],
      );
    },);
  }
}
