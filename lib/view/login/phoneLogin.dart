import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'loginStyle.dart';
import 'loginWidget.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLogin createState() => new _PhoneLogin();
}

class _PhoneLogin extends State<PhoneLogin> {
  final phoneText = TextEditingController();
  final phoneCode = TextEditingController();
  late Timer _timer;
  int _countdownTime = 0;

  void login() {
    print('userName: ' + phoneText.text + ' phoneCode: ' + phoneCode.text);
  }

  @override
  Widget build(BuildContext context) {
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

    bool validateMobile(String str) {
      return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
    }

    @override
    void dispose() {
      super.dispose();
      if (_timer != null) {
        _timer.cancel();
      }
    }

    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Material(
            color: Color.fromRGBO(245, 245, 245, 1),
            child: Column(
              children: <Widget>[
                CupertinoPageScaffold(
                  child: Form(
                    onChanged: () {
                      Form.of(primaryFocus!.context!)?.save();
                    },
                    child: CupertinoFormSection.insetGrouped(
                      header: LoginHeard(),
                      children: <Widget>[
                        CupertinoTextField(
                          controller: phoneText,
                          placeholderStyle: PhoneTextStyle(),
                          decoration: TextFieldBoxStyle(),
                          prefix: new Icon(
                            Icons.perm_identity,
                            color: Color.fromARGB(255, 126, 126, 126),
                          ),
                          placeholder: '请输入手机号',
                          cursorColor: Color.fromARGB(255, 126, 126, 126),
                          keyboardType: TextInputType.phone,
                          suffix: new IconButton(
                            icon: UserClose(),
                            onPressed: () {
                              phoneText.clear();
                            },
                          ),
                        ),
                        CupertinoTextField(
                          controller: phoneCode,
                          placeholderStyle: PhoneTextStyle(),
                          decoration: TextFieldBoxStyle(),
                          prefix: new Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 126, 126, 126),
                          ),
                          placeholder: '请输入密码',
                          cursorColor: Color.fromARGB(255, 126, 126, 126),
                          keyboardType: TextInputType.number,
                          suffix: new TextButton(
                            onPressed: () {
                              if (_countdownTime == 0&& validateMobile(phoneText.text)) {
                                //Http请求发送验证码
                                setState(() {
                                  _countdownTime = 60;
                                });
                                //开始倒计时
                                startCountdownTimer();
                              }
                            },
                            child: Text(
                              _countdownTime > 0
                                  ? '$_countdownTime后重新获取'
                                  : '获取验证码',
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                UserInfo(context, PassworLogin(context)),
                CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    color: Color(0xFFF16F15),
                    child: TextBtnStyle(),
                    onPressed: login),
                OtherLogin(),
                WeixinLogin(),
              ],
            ),
          ),
        ));
  }


}
