import 'dart:async';

import 'package:fixtures/service/api/LoginApi.dart';
import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'loginStyle.dart';
import 'loginWidget.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> with LoginMixin {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  final phoneText = TextEditingController();
  final password = TextEditingController();
  final phoneCode = TextEditingController();
  final invitation = TextEditingController();
  bool _isShowPassWord = false;
  late Timer _timer;
  int _countdownTime = 0;
  var _isPhone = false;
  var isValid = true;
  var isLogin = false;
  var isRegister = false;

  void login() {
    setState(() {
      if (isValid) {
        isLogin = true;
      }
    });
    print('userName: ' + phoneText.text + ' password: ' + password.text);

    userLogin(
        params: LoginModel(username: phoneText.text, password: password.text),
        successCallBack: (data) {
          print("1111" + data.toString());
        });
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

  void startSendSms() {
    if (_countdownTime == 0 && validateMobile(phoneText.text)) {
      //Http请求发送验证码
      setState(() {
        _countdownTime = 60;
      });
      //开始倒计时
      startCountdownTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 用户手机短信验证码输入框
    var _codeTextField = new CupertinoTextField(
      controller: phoneCode,
      placeholderStyle: PhoneTextStyle(),
      decoration: TextFieldBoxStyle(),
      padding: EdgeInsets.symmetric(vertical: 12),
      prefix: mypaddingIcon(2),
      placeholder: '请输入验证码',
      cursorColor: Color.fromARGB(255, 126, 126, 126),
      keyboardType: TextInputType.number,
      suffix: new TextButton(
        onPressed: startSendSms,
        child: Text(
          _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
    );

    /// 密码输入框
    var _passwordTextField = new CupertinoTextField(
      controller: password,
      placeholderStyle: PhoneTextStyle(),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: TextFieldBoxStyle(),
      prefix: mypaddingIcon(3),
      placeholder: '请输入密码',
      cursorColor: Color.fromARGB(255, 126, 126, 126),
      keyboardType: TextInputType.visiblePassword,
      suffixMode: OverlayVisibilityMode.editing,
      suffix: Padding(
        padding: const EdgeInsets.all(12),
        child: new GestureDetector(
          child: passwordEyeIcon(_isShowPassWord),
          onTap: () {
            setState(() {
              _isShowPassWord = !_isShowPassWord;
            });
          },
        ),
      ),
      obscureText: !_isShowPassWord,
    );

    /// 用户手机账号输入框
    var _phoneTextField = CupertinoTextField(
      controller: phoneText,
      padding: EdgeInsets.symmetric(vertical: 12),
      placeholderStyle: PhoneTextStyle(),
      decoration: TextFieldBoxStyle(),
      prefix: mypaddingIcon(1),
      prefixMode: OverlayVisibilityMode.always,
      placeholder: '请输入手机号',
      cursorColor: Color.fromARGB(255, 126, 126, 126),
      keyboardType: TextInputType.phone,
      suffixMode: OverlayVisibilityMode.editing,
      suffix: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: new GestureDetector(
            child: UserClose(),
            onTap: () {
              phoneText.clear();
            },
          ),
        ),
      ),
    );

    /// 邀请码输入框
    var _invitationField = CupertinoTextField(
      controller: invitation,
      padding: EdgeInsets.symmetric(vertical: 12),
      placeholderStyle: PhoneTextStyle(),
      decoration: TextFieldBoxStyle(),
      prefix: mypaddingIcon(1),
      prefixMode: OverlayVisibilityMode.always,
      placeholder: '邀请码',
      cursorColor: Color.fromARGB(255, 126, 126, 126),
      keyboardType: TextInputType.phone,
      suffixMode: OverlayVisibilityMode.editing,
      suffix: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: new GestureDetector(
            child: UserClose(),
            onTap: () {
              invitation.clear();
            },
          ),
        ),
      ),
    );

    /// 手机号
    var _phoneContainer = Container(
      margin: const EdgeInsets.all(18.0),
      child: _phoneTextField,
    );

    /// 密码或者验证码
    var _passwordOrCode = Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18),
      child: _isPhone ? _codeTextField : _passwordTextField,
    );

    /// 密码或者验证码
    var _invitationContainer = Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18),
      child: isRegister ? _invitationField : null,
    );

    /// 登录方式
    var _selectWay = Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: TextButton(
                  child: mySelectLoginWay(_isPhone),
                  onPressed: () {
                    setState(() {
                      isRegister = false;
                      _isPhone = !_isPhone;
                      invitation.clear();
                      password.clear();
                    });
                  },
                ),
              ),
              Container(
                child: !isRegister
                    ? TextButton(
                        child: Text(
                          '注册账号',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPhone = true;
                            isRegister = true;
                            invitation.clear();
                          });
                        },
                      )
                    : null,
              )
            ]));

    /// 登录按钮部分
    var _loginBtn = Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: myBoxDecoration(isValid),
            child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                borderRadius: BorderRadius.circular(100),
                color: CupertinoTheme.of(context).primaryColor,
                child: myCupertinoAndIcon(isLogin),
                onPressed: isValid ? login : null),
          ),
          Expanded(child: Container())
        ],
      ),
    );

    /// 输入框下面的ui
    var _underContainer = Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _selectWay,
          _loginBtn,
          OtherLogin(),
          WeixinLogin(),
        ],
      ),
    );

    return CupertinoPageScaffold(
        child: SafeArea(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ImageLogin(context),
          LoginHeard(),
          _phoneContainer,
          _passwordOrCode,
          _invitationContainer,
          _underContainer,
        ],
      ),
    ));
  }
}
