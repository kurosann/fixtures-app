import 'dart:async';

import 'package:fixtures/model/LoginModel.dart';
import 'package:fixtures/service/api/LoginApi.dart';
import 'package:fixtures/utils/EncryptUtil.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/login/loginStyle.dart';
import 'package:fixtures/view/setting/rePayPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RePwdSms extends StatefulWidget {
  @override
  _RePwdSms createState() => _RePwdSms();
}

class _RePwdSms extends State<RePwdSms> with LoginMixin {
  //获取Key用来获取Form表单组件
  final phoneText = TextEditingController();
  final password = TextEditingController();
  final againPassword = TextEditingController();
  final phoneCode = TextEditingController();
  late Timer _timer;
  int _countdownTime = 0;
  var isLogin = false;
  var isRegister = false;
  var isErr = false;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void openMsg(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: () {
                  setState(() {
                    isLogin = false;
                  });
                  Navigator.of(context).pop("ok");
                },
              ),
            ],
          );
        });
  }

  void resPWd() {
    var pas = EncryptUtil.aesEncrypt(password.text);
    var models = SmsLoginModel(
        phone: phoneText.text,
        password: pas,
        smsCode: phoneCode.text,
        invitationCode: "");
    resetPasswordSms(
      params: models,
      successCallBack: (data) {
        Navigator.of(context).pop(CupertinoPageRoute(
          builder: (context) {
            return RePayPassword();
          },
        ));
      },
      errorCallBack: (code, err) {
        openMsg(err);
      },
    );
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  /// 发送短信验证码
  void sendResetSms() async {
    if (_countdownTime == 0) {
      /// 注册验证码
      sendResetPasswordSms(
        successCallBack: (data) {},
        errorCallBack: (code, err) {
          openMsg(err);
        },
      );

      /// Http请求发送验证码
      setState(() {
        _countdownTime = 60;
      });
      //开始倒计时
      startCountdownTimer();
    }
  }

  Widget _topTitle(context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("密码设置",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  /// 用户手机短信验证码输入框
  Widget _codeTextField() {
    return CupertinoTextField(
      controller: phoneCode,
      placeholderStyle: PhoneTextStyle(),
      decoration: TextFieldBoxStyle(),
      padding: EdgeInsets.symmetric(vertical: 12),
      prefix: Padding(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.email,
          color: inputColor(),
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.digitsOnly
      ],
      placeholder: '请输入验证码',
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.number,
      suffix: TextButton(
        onPressed: sendResetSms,
        child: Text(
          _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
    );
  }

  /// 验证码
  Widget _Code() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16,top: 50, bottom: 16),
      child: _codeTextField(),
    );
  }

  /// 登录按钮部分
  Widget _rePwdBtn() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'next',
            child: CupertinoButton.filled(
                child: Text("下一步"),
                onPressed: () {
                  // resPWd();
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return RePayPassword();
                    },
                  ));
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("支付密码设置"),
        ),
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            _Code(),
            _rePwdBtn(),
          ],
        ));
  }

  Color inputColor() => CupertinoColors.inactiveGray;
}
