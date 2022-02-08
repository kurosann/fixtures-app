import 'dart:async';

import 'package:fixtures/model/IdCardModel.dart';
import 'package:fixtures/service/api/IdCardApi.dart';
import 'package:fixtures/view/login/loginStyle.dart';
import 'package:fixtures/view/setting/payField/customJPasswordField.dart';
import 'package:fixtures/view/setting/payField/keyboard.dart';
import 'package:fixtures/view/setting/payField/keyboard_main.dart';
import 'package:fixtures/view/setting/payField/pay_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'addBankCard.dart';

class WithdrawPage extends StatefulWidget {
  final String balance;
  static final String sName = "enter";
  WithdrawPage(this.balance);

  @override
  State<StatefulWidget> createState() => _WithdrawPageState(balance);
}

class _WithdrawPageState extends State<WithdrawPage> with IdCardApi {
  String balance;
  var IdCardList = <IdCardModel>[];
  var actionsWidget = <CupertinoActionSheetAction>[];
  late Timer _timer;
  int _countdownTime = 0;
  var way = 0;
  var wayName = "请选择提现方式";
  var total = 0;
  final phoneCode = TextEditingController();
  var _controller = TextEditingController();

  String pwdData = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showBottomSheetCallback;

  _WithdrawPageState(this.balance);

  void findIdCard() {
    getIdCard(successCallBack: (data) {
      IdCardList = <IdCardModel>[];
      setState(() {
        total = data["total"];
        var list = data["list"];
        for (int i = 0; i < total; i += 1) {
          actionsWidget.add(CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                way = list[i]["id"];
                wayName = list[i]["bankName"];
              });
              Navigator.of(context).pop();
            },
            child: Text(list[i]["bankName"],
                style: TextStyle(color: Colors.black87)),
          ));
        }
      });
    }, errorCallBack: (code, err) {
      if (code == 500) {
        openMsg(err);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _showBottomSheetCallback = _showBottomSheet;
    findIdCard();

  }

  Widget _buildContent(BuildContext c) {
    return new Container(
      child: new Column(
        children: <Widget>[
          ///密码框
          new Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildPwd(pwdData),
          ),
        ],
      ),
    );
  }



  /// 密码键盘 确认按钮 事件
  void onAffirmButton() {
    // 打印支付宝密码
    print(pwdData);
  }

  void _onKeyDown(KeyEvents data) {
    if (data.isDelete()) {
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      if (pwdData.length != 6) {
//        Fluttertoast.showToast(msg: "密码不足6位，请重试", gravity: ToastGravity.CENTER);
        return;
      }
      onAffirmButton();
    } else {
      if (pwdData.length < 6) {
        pwdData += data.key;
      }
      setState(() {});
    }
  }

  /// 底部弹出 自定义键盘  下滑消失
  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        ?.showBottomSheet<void>((BuildContext context) {
          return new MyKeyboard(_onKeyDown);
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  Widget _buildPwd(var pwd) {
    return new GestureDetector(
      child: new Container(
        width: 250.0,
        height: 40.0,
//      color: Colors.white,
        child: new CustomJPasswordField(pwd),
      ),
      onTap: () {
        _showBottomSheetCallback = _showBottomSheet;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        key: _scaffoldKey,
        backgroundColor: CupertinoColors.systemGroupedBackground,
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: '余额',
          middle: Text("提现"),
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
                            "提现方式",
                            style: TextStyle(fontSize: 14),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.all(0),
                            minSize: 0,
                            alignment: Alignment.bottomLeft,
                            onPressed: () {
                              if (total == 0) {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text('提示'),
                                        content: Text("没有银行卡请先添加"),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text('确认'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(CupertinoPageRoute(
                                                builder: (context) {
                                                  return AddBankCard();
                                                },
                                              ));
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                _showPopupModel(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        FontAwesomeIcons.wallet,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      wayName,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black87),
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
                              "提现金额",
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'Withdraw',
                        child: CupertinoButton.filled(
                            child: Text("提现"),
                            onPressed: () {
                              // showCupertinoDialog(
                              //     context: context,
                              //     builder: (c) {
                              //       return CupertinoAlertDialog(
                              //         title: Text('请输入支付密码'),
                              //         content: _buildContent(c),
                              //         actions: <Widget>[
                              //           _buildContent(c),
                              //           CupertinoDialogAction(
                              //             child: Text('确认'),
                              //             onPressed: () {
                              //               Navigator.of(context).pop("ok");
                              //             },
                              //           ),
                              //         ],
                              //       );
                              //     });
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(
                                builder: (context) {
                                  return main_keyboard();
                                },
                              ));
                            }),
                      ),
                    ],
                  ),
                ),
                rulesTile(),
                rulesBody(),
              ],
            ),
          ),
        ));
  }

  Widget rulesTile() {
    return Container(
        padding: EdgeInsets.only(top: 40),
        child: Row(children: <Widget>[
          Expanded(
            child: Divider(height: 1, color: Colors.grey),
          ),
          Expanded(
              child: Text(
            '提现须知',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
              color: Colors.orange,
            ),
            textAlign: TextAlign.center,
          )),
          Expanded(
            child: Divider(height: 1, color: Colors.grey),
          ),
        ]));
  }

  // color: Color.fromARGB(255, 250, 130, 65)),
  Widget rulesBody() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.all(10),
        child: Row(children: <Widget>[
          Expanded(
            child: Text(
                '1.仅支持账户全额提现，实际到账金额以当日结算为准。\n'
                '2.申请审核通过后，抵用券自动作废。\n'
                '3.提现将扣除相应的充值优惠。\n'
                '4.工作日星期二至星期五可作为提现时间 \n',
                maxLines: 20,
                style: TextStyle(
                  fontSize: 15.0,
                  color: CupertinoColors.black,
                )),
          ),
        ]));
  }

  /// 用户手机短信验证码输入框
  Widget codeSms() {
    return Container(
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
  }

  void openMsg(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (c) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
              )
            ],
          );
        });
  }

  void _showPopupModel(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: actionsWidget,
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
