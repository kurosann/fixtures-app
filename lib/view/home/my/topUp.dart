import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopUpPage extends StatefulWidget {
  final String balance;

  TopUpPage(this.balance);

  @override
  State<StatefulWidget> createState() => _TopUpPageState(balance);
}

class _TopUpPageState extends State<TopUpPage> {
  String balance;

  var way = 0;

  var _controller = TextEditingController();

  _TopUpPageState(this.balance);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: '余额',
          middle: Text("充值"),
        ),
        child: SafeArea(
          child: GestureDetector(
            onPanDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);

              /// 键盘是否是弹起状态
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "充值方式",
                            style: TextStyle(fontSize: 14),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              _showPopupModel(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
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
                                          fontSize: 20,
                                          color: way == 0
                                              ? Colors.green
                                              : Colors.blue),
                                    )
                                  ],
                                ),
                                Expanded(child: Container()),
                                Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.grey,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 6, right: 6),
                        child: CupertinoTextField(
                          clearButtonMode: OverlayVisibilityMode.editing,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          autofocus: true,
                          prefix: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
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
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'TopUp',
                        child: CupertinoButton.filled(
                            child: Text("充值"), onPressed: () {}),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
