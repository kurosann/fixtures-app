import 'dart:async';

import 'package:fixtures/model/LoginModel.dart';
import 'package:fixtures/service/api/LoginApi.dart';
import 'package:fixtures/utils/EncryptUtil.dart';
import 'package:fixtures/utils/SharedPreferencesUtil.dart';
import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void SuccessFunc(dynamic data)  {
    setState(() {
      isLogin = false;
    });
    var securityKey = data["securitykey"];
    var token = data["token"];
    var aes = EncryptUtil.aesEncrypt(securityKey);
    print("存储aes:" + aes);

    /// 存储securitykey、token
    SharedPreferencesUtil.putData('token', token);
    SharedPreferencesUtil.putData('securitykey', aes);

    /// 登录并跳转
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) {
        return HomePage();
      },
    ));
   // Navigator.pushReplacement(context);
  }

  void login() {
    if (isValid) {
      setState(() {
        isLogin = true;
      });
    } else {
      return;
    }
    var pas = EncryptUtil.aesEncrypt(password.text);

    var models = SmsLoginModel(
        phone: phoneText.text,
        password: pas,
        smsCode: phoneCode.text,
        invitationCode: invitation.text);
    if (true) {
      if (_isPhone) {
        /// 手机号
        if (isRegister) {
          /// 注册按钮
          RegisterSms(
            params: models,
            successCallBack: (data) {
              SuccessFunc(data);
            },
            errorCallBack: (code, err) {
              if (code == 500) {
                openMsg(err);
              }
            },
          );
        } else {
          loginSms(
            params: models,
            successCallBack: (data) {
              SuccessFunc(data);
            },
            errorCallBack: (code, err) {
              if (code == 500) {
                openMsg(err);
              }
            },
          );
        }
      } else {
        /// 账号密码
        loginPwd(
          params: models,
          successCallBack: (data) {
            print(data);
            SuccessFunc(data);
          },
          errorCallBack: (code, err) {
            print(code);
            if (code == 500) {
              openMsg(err);
            }
          },
        );
      }
    }
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
  void startSendSms() async {
    var models = SmsLoginModel(
        phone: phoneText.text,
        smsCode: phoneCode.text,
        invitationCode: invitation.text);
    if (_countdownTime == 0 && validateMobile(phoneText.text)) {
      if (isRegister) {
        /// 注册验证码
        sendRegisterSms(
          params: models,
          successCallBack: (data) {
            SuccessFunc(data);
          },
          errorCallBack: (code, err) {
            openMsg(err);
          },
        );
      } else {
        /// 登录验证码
        sendLoginSms(
          params: models,
          successCallBack: (data) {
            SuccessFunc(data);
          },
          errorCallBack: (code, err) {
            openMsg(err);
          },
        );
      }

      /// Http请求发送验证码
      setState(() {
        _countdownTime = 60;
      });
      //开始倒计时
      startCountdownTimer();
    }
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
        onPressed: startSendSms,
        child: Text(
          _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
    );
  }

  /// 密码输入框
  Widget _passwordTextField() {
    return CupertinoTextField(
      controller: password,
      placeholderStyle: PhoneTextStyle(),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: TextFieldBoxStyle(),
      prefix: Padding(
        padding: EdgeInsets.all(12),
        child: new Icon(
          Icons.lock,
          color: inputColor(),
        ),
      ),
      placeholder: '请输入密码',
      keyboardType: TextInputType.visiblePassword,
      suffixMode: OverlayVisibilityMode.editing,
      inputFormatters: [LengthLimitingTextInputFormatter(16)],
      suffix: Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          child: Icon(
            _isShowPassWord ? Icons.visibility : Icons.visibility_off,
            size: 18,
            color: inputColor(),
          ),
          onTap: () {
            setState(() {
              _isShowPassWord = !_isShowPassWord;
            });
          },
        ),
      ),
      obscureText: !_isShowPassWord,
    );
  }

  Widget ImageLogin(context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/ss.png",
              width: MediaQuery.of(context).size.width,
              height: 110,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }

  /// 用户手机账号输入框
  Widget _phoneTextField() {
    return CupertinoTextField(
        controller: phoneText,
        padding: EdgeInsets.symmetric(vertical: 12),
        placeholderStyle: PhoneTextStyle(),
        decoration: TextFieldBoxStyle(),
        prefix: Padding(
          padding: EdgeInsets.all(12),
          child: new Icon(
            Icons.person,
            color: inputColor(),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter.digitsOnly
        ],
        placeholder: '请输入手机号',
        keyboardType: TextInputType.phone,
        clearButtonMode: OverlayVisibilityMode.editing);
  }

  /// 邀请码输入框
  Widget _invitationField() {
    return CupertinoTextField(
        controller: invitation,
        padding: EdgeInsets.symmetric(vertical: 12),
        placeholderStyle: PhoneTextStyle(),
        decoration: TextFieldBoxStyle(),
        inputFormatters: [LengthLimitingTextInputFormatter(6)],
        prefix: Padding(
          padding: EdgeInsets.all(12),
          child: new Icon(
            Icons.person,
            color: inputColor(),
          ),
        ),
        placeholder: '邀请码',
        keyboardType: TextInputType.number,
        clearButtonMode: OverlayVisibilityMode.editing);
  }

  /// 手机号
  Widget _phoneContainer() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: _phoneTextField(),
    );
  }

  /// 密码或者验证码
  Widget _passwordOrCode() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: _isPhone ? _codeTextField() : _passwordTextField(),
    );
  }

  /// 密码或者验证码
  Widget _invitationContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18),
      child: isRegister ? _invitationField() : null,
    );
  }

  /// 登录方式
  Widget _selectWay() {
    return Container(
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
  }

  /// 登录按钮部分
  Widget _loginBtn() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: (isValid && !isLogin)
                          ? Color.fromARGB(255, 200, 200, 200)
                          : Colors.white,
                      blurRadius: 0.1,
                      offset: Offset(0.1, 0.1),
                      spreadRadius: 1)
                ]),
            child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                borderRadius: BorderRadius.circular(100),
                color: CupertinoTheme.of(context).primaryColor,
                child: isLogin
                    ? CupertinoActivityIndicator()
                    : Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                onPressed: (isValid && !isLogin) ? login : null),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }

  /// 输入框下面的ui
  Widget _underContainer() {
    return Container(
      child: Column(
        children: [isRegister ? Container() : OtherLogin()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  ImageLogin(context),
                  LoginHeard(),
                  _phoneContainer(),
                  _passwordOrCode(),
                  _invitationContainer(),
                  _selectWay(),
                  _loginBtn(),
                ],
              ),
            ),
            Positioned(left: 0, right: 0, bottom: 50, child: _underContainer()),
          ])
        ],
      ),
    ));
  }

  Color inputColor() => CupertinoColors.inactiveGray;
}
